#!/bin/bash 
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
source $OCI_VM_K8S/domain-on-pv/env.sh

echo ""
echo ""
echo "======================="

#read -p "Enter domain name: " useroption
export NS_NAME=pv-domain1
source $SCRIPT_HOME/core-k8s-scripts/domain-on-pv/env.sh

$DOMAIN_ON_PV_HOME/install_kubernetes_operator.sh

mkdir -p $K8S_DOMAIN_HOME/$NS_NAME
cp -r $K8S_DOMAIN_HOME/vaniladomain/vaniladomain.properties  $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
ls -ltr $K8S_DOMAIN_HOME/$NS_NAME
cd $K8S_DOMAIN_HOME/$NS_NAME
cp $DOMAIN_ON_PV_K8S_SAMPLE/create-domain-inputs.yaml $K8S_DOMAIN_HOME/$NS_NAME

sed -i s/domain1/pv-domain1/g  $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml
sed -i s/#imagePullSecretName:/imagePullSecretName:\ docker-store/g $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml
sed -i s/default/$NS_NAME-ns/g $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml
sed -i s/weblogic-sample/pv-domain1/g $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml
sed -i s/create-$NS_NAME-domain-inputs-v1/create-weblogic-sample-domain-inputs-v1/g $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml

cp $PV_K8S_SAMPLE/create-pv-pvc-inputs.yaml $K8S_DOMAIN_HOME/$NS_NAME
sed -i s/weblogic-sample/pv-domain1/g $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml
sed -i s/domainUID:/domainUID:\ pv-domain1/g $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml
sed -i s/default/pv-domain1-ns/g $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml
sed -i s/#weblogicDomainStoragePath:/weblogicDomainStoragePath:/g $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml
sed -i s/scratch\\/k8s_dir/kube_dir/g $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml
sed -i /create-$NS_NAME-domain-inputs-v1/create-weblogic-sample-domain-inputs-v1/g $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml

sed -i s/sample-domain1/$NS_NAME/g $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties

source $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
#sed -i 's/sample-domain1/'''$NS_NAME'''/g' *.properties
#vi *
cp $K8S_DOMAIN_HOME/$NS_NAME/create-pv-pvc-inputs.yaml $PV_K8S_SAMPLE/create-pv-pvc-inputs.yaml
cp $K8S_DOMAIN_HOME/$NS_NAME/create-domain-inputs.yaml $DOMAIN_ON_PV_K8S_SAMPLE/create-domain-inputs.yaml
source $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
sleep 10
cd -
echo ""
echo ""

$DOMAIN_ON_PV_HOME/apply_services_account_k8s.sh $NS_NAME
$DOMAIN_ON_PV_HOME/create_ns_kubernetes_operator.sh $NS_NAME
$DOMAIN_ON_PV_HOME/install_helm_operator_chart.sh $NS_NAME
$DOMAIN_ON_PV_HOME/deploy_wls_domain.sh $NS_NAME
$DOMAIN_ON_PV_HOME/upgrade_helm_all_operator.sh $NS_NAME
$DOMAIN_ON_PV_HOME_VANILA/create_docker_store.sh $NS_NAME
$DOMAIN_ON_PV_HOME_VANILA/create_pv_pvc.sh $NS_NAME
$DOMAIN_ON_PV_HOME_VANILA/create_domain_input.sh $NS_NAME
$DOMAIN_ON_PV_HOME_VANILA/apply_sample_domain.sh $NS_NAME
$LB_HOME/select_lb.sh $NS_NAME
$DOMAIN_ON_PV_HOME/list_details.sh $NS_NAME
