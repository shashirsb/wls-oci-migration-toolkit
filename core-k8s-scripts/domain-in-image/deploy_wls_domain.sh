#!/bin/bash
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains
export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts

source $OCI_VM_K8S/env.sh

export NS_NAME=$1

source $K8S_DOMAIN_HOME/$NS_NAME/$NS_NAME.properties
clear 
$SCRIPT_HOME/header.sh
echo ""
echo ""
echo ""
echo "Step 1 - Cloned > Step 2 - Created >  Step 3 - Installed > Step 4 - Creating"
echo "Git K8s Opr       Service Account     k8s Opr (via helm)   Weblogic domain  "
echo " "
echo " "
echo "Deploying a WebLogic domain:"
echo "============================"
echo " "
echo " "
echo "Input >>>"
echo "Create namespace $NS_NAME-ns"
echo ""
echo "<<< Output"
echo "kubectl create namespace $NS_NAME-ns"
kubectl create namespace $NS_NAME-ns
echo " "
echo " "
echo "Input >>>"
echo "Create Secret username/password"
echo ""
echo "<<< Output"
echo "kubectl -n $NS_NAME-ns create secret generic $NS_NAME-weblogic-credentials --from-literal=username=$K8S_USERNAME --from-literal=password=$K8S_PASSWORD"
kubectl -n $NS_NAME-ns create secret generic $NS_NAME-weblogic-credentials --from-literal=username=$K8S_USERNAME --from-literal=password=$K8S_PASSWORD
echo " "
echo " "
echo "Input >>>"
echo "Create Label for the secret"
echo ""
echo "<<< Output"
echo "kubectl label secret $NS_NAME-weblogic-credentials -n $NS_NAME-ns weblogic.domainUID=$NS_NAME weblogic.domainName=$NS_NAME"
kubectl label secret $NS_NAME-weblogic-credentials -n $NS_NAME-ns weblogic.domainUID=$NS_NAME weblogic.domainName=$NS_NAME
echo ""
echo ""
echo ""
echo "Input >>>"
echo "Create docker hub secret"
echo ""
echo "<<< Output"
echo "kubectl  create secret docker-registry docker-hub-store --docker-server=docker.io --docker-username=$DOCKERHUB_USERNAME --docker-password=$DOCKERHUB_PASSWORD  -n $NS_NAME-ns"
kubectl create secret docker-registry docker-hub-store --docker-server=docker.io --docker-username=$DOCKERHUB_USERNAME --docker-password=$DOCKERHUB_PASSWORD  -n $NS_NAME-ns
echo ""
echo ""
#echo "Successfully deployed weblogic domain"
echo "====================================="
echo ""
read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    continue;
else
   exit;
fi
