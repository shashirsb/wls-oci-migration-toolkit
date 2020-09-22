#!/bin/bash
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains
export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts

source $OCI_VM_K8S/env.sh

export NS_NAME=$1

echo "Install Helm Weblogic Operator Chart:"
echo "=============================="
helm repo add stable https://kubernetes-charts.storage.googleapis.com

cd $HOME/weblogic-kubernetes-operator

echo "helm install $NS_NAME-weblogic-operator kubernetes/charts/weblogic-operator --namespace $NS_NAME-weblogic-operator-ns --set image=oracle/weblogic-kubernetes-operator:$WLS_KUBE_OPTR --set serviceAccount=$NS_NAME-weblogic-operator-sa --set "domainNamespaces={}" --wait"
helm install $NS_NAME-weblogic-operator kubernetes/charts/weblogic-operator --namespace $NS_NAME-weblogic-operator-ns --set image=oracle/weblogic-kubernetes-operator:$WLS_KUBE_OPTR --set serviceAccount=$NS_NAME-weblogic-operator-sa --set "domainNamespaces={}" --wait

echo "Successfully installed kubernetes/charts/weblogic-operator "
echo "==========================================================="
sleep 3
