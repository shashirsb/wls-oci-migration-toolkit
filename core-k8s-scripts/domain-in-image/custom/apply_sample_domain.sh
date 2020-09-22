#!/bin/bash  
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
source $OCI_VM_K8S/env.sh
export NS_NAME=$1
source $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
echo " "
echo " "
echo "Create $NS_NAME on Kubernetes"
echo "========================================="
echo " "
echo " "
cd $DOMAIN_IN_IMAGE_K8S_SAMPLE

cp create-domain-inputs.yaml $NS_NAME-create-domain-inputs.yaml
sed -i s/domain1/$NS_NAME/g $NS_NAME-create-domain-inputs.yaml
sed -i s/"namespace: default"/"namespace: $NS_NAME-ns"/g $NS_NAME-create-domain-inputs.yaml
vi $NS_NAME-create-domain-inputs.yaml
echo "Input >>>"
echo "./create-domain.sh -i $NS_NAME-create-domain-inputs.yaml -o output -u $K8S_USERNAME -p xxxxxxxx"
echo ""
echo ""
echo "Output <<<"
./create-domain.sh -i $NS_NAME-create-domain-inputs.yaml -o output -u $K8S_USERNAME -p $K8S_PASSWORD
echo ""
echo ""
read -p "Enter wls version, 12.2.1.3 or 12.2.1.4: " wlsversion
export WLS_VERSION_FOR_IMAGE=$wlsversion
echo ""
echo ""
echo "Lets push the docker image to docker hub"
echo " docker tag domain-home-in-image:$WLS_VERSION_FOR_IMAGE docker.io/$DOCKERHUB_USERNAME/$NS_NAME-domain-home-in-image:$WLS_VERSION_FOR_IMAGE"
echo " docker push docker.io/$DOCKERHUB_USERNAME/$NS_NAME-domain-home-in-image:$WLS_VERSION_FOR_IMAGE"
 docker tag domain-home-in-image:$WLS_VERSION_FOR_IMAGE docker.io/$DOCKERHUB_USERNAME/$NS_NAME-domain-home-in-image:$WLS_VERSION_FOR_IMAGE
 docker push docker.io/$DOCKERHUB_USERNAME/$NS_NAME-domain-home-in-image:$WLS_VERSION_FOR_IMAGE
echo ""
echo ""
echo "cd output/weblogic-domains/$1"
cd output/weblogic-domains/$1

# Copying files to  bastion folder
sed -i s/"domain-home-in-image:$WLS_VERSION_FOR_IMAGE"/"docker.io\/$DOCKERHUB_USERNAME\/$NS_NAME-domain-home-in-image:$WLS_VERSION_FOR_IMAGE"/g domain.yaml
vi domain.yaml
cp -R * $K8S_DOMAIN_HOME/$NS_NAME/

echo "kubectl create -f domain.yaml -n $NS_NAME-ns"
kubectl create -f domain.yaml -n $NS_NAME-ns

echo " "
echo " "
echo " "
echo " $NS_NAME created Successfully!!!"
sleep 5
