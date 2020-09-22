#!/bin/bash
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains
export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts

source $OCI_VM_K8S/env.sh

export NS_NAME=$1
echo " "
echo " "
echo "Deploying a WebLogic domain on Kubernetes"
echo "========================================="
echo " "
echo " "
echo "Get the sample domain.yaml file and save locally"
#curl -LSs https://raw.githubusercontent.com/nagypeter/weblogic-operator-tutorial/master/k8s/domain_short.yaml >domain.yaml
echo " "
echo " "
echo "apply the domain.yaml to k8s cluster"
echo "kubectl apply -f $K8S_DOMAIN_HOME/$NS_NAME/domain.yaml"
kubectl apply -f $K8S_DOMAIN_HOME/$NS_NAME/domain.yaml
sleep 5

