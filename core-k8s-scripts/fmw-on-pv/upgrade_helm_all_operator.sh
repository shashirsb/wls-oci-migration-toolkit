#!/bin/bash
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains
export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
source $OCI_VM_K8S/env.sh
export NS_NAME=$1

echo " "
echo " "
cd $HOME/weblogic-kubernetes-operator
echo " "
echo " "
echo "Input >>>"
echo "Helm upgrade weblogic operator"
echo ""
echo "<<< Output"
echo "helm upgrade --reuse-values --set "domainNamespaces={$NS_NAME-ns}" --wait $NS_NAME-weblogic-operator kubernetes/charts/weblogic-operator -n $NS_NAME-weblogic-operator-ns"
helm upgrade --reuse-values --set "domainNamespaces={$NS_NAME-ns}" --wait $NS_NAME-weblogic-operator kubernetes/charts/weblogic-operator -n $NS_NAME-weblogic-operator-ns
echo " "
echo " "
read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    continue;
else
   exit;
fi
