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
echo "Step 1 - Cloned > Step 2 - Created >  Step 3 - Installed > Step 4 - Created > Step 5 - Installed"
echo "Git K8s Opr       Service Account     k8s Opr (via helm)   Weblogic domain      traefik (via helm)"
echo ""
echo ""
echo " Installation is complete"
echo ""
echo ""
echo " List all for namespaces $NS_NAME-ns "
echo "=============="
echo "kubectl get all -n $NS_NAME-ns"
kubectl get all -n $NS_NAME-ns
echo " "
echo " "
echo "List the operator release:"
echo "============================="
echo "helm list --all-namespaces"
helm list --all-namespaces
echo " "
echo " "
sleep 10
echo "watch -n 10 "$SCRIPT_HOME/header.sh&& echo '' && echo '' &&  echo '' && kubectl get pods -n $NS_NAME-ns -o wide""
watch -n 10 "$SCRIPT_HOME/header.sh && echo '' && echo '' &&  echo '' && kubectl get pods -n $NS_NAME-ns -o wide"

read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    if [ $DOMAIN_TYPE == 'vanila' ]; then
    $SCRIPT_HOME/wls-migrate.sh option_k8s_4_wls_vanila
    elif [ $DOMAIN_TYPE == 'custom' ]; then
    $SCRIPT_HOME/wls-migrate.sh option_k8s_5_wls_custom
    fi
fi
