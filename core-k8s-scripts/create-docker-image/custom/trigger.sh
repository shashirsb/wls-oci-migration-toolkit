#!/bin/bash 
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
source $OCI_VM_K8S/env.sh

echo ""
echo ""
echo "======================="

read -p "Enter docker image name: " useroption
export NS_NAME=$useroption
mkdir -p $K8S_DOMAIN_HOME/$NS_NAME
cp -r $K8S_DOMAIN_HOME/vaniladomain/*  $K8S_DOMAIN_HOME/$NS_NAME
cp $OCI_VM_K8S/access.permission.yaml $K8S_DOMAIN_HOME/$NS_NAME
ls -ltr $K8S_DOMAIN_HOME/$NS_NAME
mv $K8S_DOMAIN_HOME/$NS_NAME/vaniladomain.properties $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
cd $K8S_DOMAIN_HOME/$NS_NAME

sed -i s/sample-domain1/$NS_NAME/g  $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
sed -i s/sample-domain1/$NS_NAME/g  $K8S_DOMAIN_HOME/$NS_NAME/traefik-ingress-rule.yaml

#sed -i 's/sample-domain1/'''$NS_NAME'''/g' *.properties
vi $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties

source $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
echo $K8S_PASSWORD
echo $K8S_USERNAME
cd -
echo ""
echo ""

$CREATE_DOCKER_IMAGE_HOME/install_kubernetes_operator.sh $NS_NAME
$CREATE_DOCKER_IMAGE_HOME/deploy_wls_domain.sh $NS_NAME
$CREATE_DOCKER_IMAGE_HOME_CUSTOM/tag_docker_image.sh $NS_NAME
$CREATE_DOCKER_IMAGE_HOME/list_details.sh $NS_NAME
