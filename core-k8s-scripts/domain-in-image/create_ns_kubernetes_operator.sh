#!/bin/bash
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains
export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts

source $OCI_VM_K8S/env.sh

export NS_NAME=$1
clear
$SCRIPT_HOME/header.sh
echo ""
echo ""
echo ""
echo "Step 1 - Cloned > Step 2 - Created >  Step 3 - Installing"
echo "Git K8s Opr       Service Account     k8s Opr (via helm)"
echo ""
echo ""
echo "Input >>>"
echo "Create namespace for kubernetes operator:"
echo ""
echo "<<< Output"
echo "kubectl create namespace $NS_NAME-weblogic-operator-ns"
kubectl create namespace $NS_NAME-weblogic-operator-ns
echo ""
echo ""
echo "Input >>>"
echo "Create service account for kubernetes weblogic operator namespace:"
echo ""
echo "<<< Output"
echo "kubectl create serviceaccount -n $NS_NAME-weblogic-operator-ns $NS_NAME-weblogic-operator-sa"
kubectl create serviceaccount -n $NS_NAME-weblogic-operator-ns $NS_NAME-weblogic-operator-sa
echo ""
echo ""

sleep 5
echo " "
echo " "
