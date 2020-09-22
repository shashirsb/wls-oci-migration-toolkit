#!/bin/bash 
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
export BASTION_HOME=$SCRIPT_HOME/bastion
export K8S_DOMAIN_HOME=$SCRIPT_HOME/bastion/output

echo ""
echo ""
echo "======================="
#read -p "Enter domain name: " useroption
export NS_NAME=sample-domain1
cp -r $K8S_DOMAIN_HOME/vaniladomain  $K8S_DOMAIN_HOME/$NS_NAME
ls -ltr $K8S_DOMAIN_HOME/$NS_NAME
mv $K8S_DOMAIN_HOME/$NS_NAME/vaniladomain.properties $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
cd $K8S_DOMAIN_HOME/$NS_NAME
sed -i 's/sample-domain1/'''$NS_NAME'''/g' *.properties
vi *

source $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
echo $K8S_PASSWORD
echo $K8S_USERNAME
cd -
echo ""
echo ""

./install_kubernetes_operator.sh
./apply_services_account_k8s.sh
./create_ns_kubernetes_operator.sh
./install_helm_operator_chart.sh
./install_traefik_helm_chart.sh
./list_details.sh
./check_lb_working.sh
./deploy_wls_domain.sh
./upgrade_helm_all_operator.sh
./wdt_apply_traefik_sample.sh 
./wdt_apply_sample_domain.sh
#./wdt_domain_deploy.sh
