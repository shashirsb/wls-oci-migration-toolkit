#!/bin/bash 
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
source $OCI_VM_K8S/env.sh

echo ""
echo ""
echo "======================="

#read -p "Enter domain name: " useroption
export NS_NAME=soa-domain1

$FMW_ON_PV_HOME/install_kubernetes_operator.sh

mkdir -p $K8S_DOMAIN_HOME/$NS_NAME
cp -r $K8S_DOMAIN_HOME/vaniladomain/vaniladomain.properties  $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
ls -ltr $K8S_DOMAIN_HOME/$NS_NAME
cd $K8S_DOMAIN_HOME/$NS_NAME
cp $PV_K8S_SOA_SAMPLE/create-domain-inputs.yaml $K8S_DOMAIN_HOME/$NS_NAME

sed -i s/oracle-db.default/oracle-db.$NS_NAME-ns/g  $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml
sed -i s/soainfra-domain-pvc/$NS_NAME-$NS_NAME-pvc/g $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml
sed -i s/soainfra-domain-credentials/$NS_NAME-weblogic-credentials/g $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml
sed -i s/soans/$NS_NAME-ns/g  $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml
sed -i s/soainfra/$NS_NAME/g  $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml
sed -i s/domainType:\ soa/domainType:\ soaessosb/g  $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml
sed -i s/#imagePullSecretName:/imagePullSecretName:\ docker-store/g $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml

cp $PV_K8S_SAMPLE/create-pv-pvc-inputs.yaml $K8S_DOMAIN_HOME/$NS_NAME
sed -i s/baseName:\ weblogic-sample/baseName:\ $NS_NAME/g $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml
sed -i s/domainUID:/domainUID:\ $NS_NAME/g $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml
sed -i s/default/$NS_NAME-ns/g $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml
sed -i s/#weblogicDomainStoragePath:/weblogicDomainStoragePath:/g $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml
sed -i s/scratch\\/k8s_dir/kube_dir/g $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml

cp $DB_SAMPLE/common/oracle.db.yaml $K8S_DOMAIN_HOME/$NS_NAME
sed -i s/default/$NS_NAME-ns/g $K8S_DOMAIN_HOME/$NS_NAME/oracle.db.yaml
sed -i s/$NS_NAME-ns-scheduler/default-scheduler/g $K8S_DOMAIN_HOME/$NS_NAME/oracle.db.yaml

# do not uncomment as rcu will run in defualt namespace
#cp $RCU_SCHEMA_SAMPLE/common/rcu.yaml $K8S_DOMAIN_HOME/$NS_NAME
#sed -i s/default/$NS_NAME-ns/g $K8S_DOMAIN_HOME/$NS_NAME/rcu.yaml


sed -i s/sample-domain1/$NS_NAME/g $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties

source $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
#sed -i 's/sample-domain1/'''$NS_NAME'''/g' *.properties
echo "
initContainers:
        - name: fix-pvc-owner
          image: %WEBLOGIC_IMAGE%
          command: ["sh", "-c", "chown -R 1000:1000 %DOMAIN_ROOT_DIR%"]
          volumeMounts:
          - name: fmw-infra-sample-domain-storage-volume
            mountPath: %DOMAIN_ROOT_DIR%
          securityContext:
            runAsUser: 0
            runAsGroup: 0
"
read -p "Enter Y/y to continue: " user_in

vi $PV_K8S_SOA_SAMPLE/create-domain-job-template.yaml
#vi *
cp $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml $PV_K8S_SAMPLE/create-pv-pvc-inputs.yaml
cp $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml $PV_K8S_SOA_SAMPLE/create-domain-inputs.yaml
cp $K8S_DOMAIN_HOME/$NS_NAME/oracle.db.yaml $DB_SAMPLE/common/oracle.db.yaml
source $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
sleep 5 
cd -
echo ""
echo ""

$FMW_ON_PV_HOME/apply_services_account_k8s.sh $NS_NAME
$FMW_ON_PV_HOME/create_ns_kubernetes_operator.sh $NS_NAME
$FMW_ON_PV_HOME/install_helm_operator_chart.sh $NS_NAME

$FMW_ON_PV_HOME/deploy_wls_domain.sh $NS_NAME
$FMW_ON_PV_HOME/upgrade_helm_all_operator.sh $NS_NAME
$FMW_ON_PV_HOME_VANILA/create_docker_store.sh $NS_NAME
$FMW_ON_PV_HOME/create_db_service.sh $NS_NAME
$FMW_ON_PV_HOME/create_rcu.sh $NS_NAME
$FMW_ON_PV_HOME_VANILA/create_pv_pvc.sh $NS_NAME
$FMW_ON_PV_HOME_VANILA/create_domain_input.sh $NS_NAME
$FMW_ON_PV_HOME_VANILA/apply_sample_domain.sh $NS_NAME
$LB_HOME/select_lb.sh $NS_NAME
$FMW_ON_PV_HOME/list_details.sh $NS_NAME
