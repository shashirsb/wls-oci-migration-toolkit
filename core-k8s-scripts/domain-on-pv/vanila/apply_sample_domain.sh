#!/bin/bash
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
source $OCI_VM_K8S/domain-on-pv/env.sh
export NS_NAME=$1
echo " "
echo " "
cp -R $DOMAIN_ON_PV_K8S_SAMPLE/output/weblogic-domains/$NS_NAME/* $K8S_DOMAIN_HOME/$NS_NAME/

#cd $DOMAIN_ON_PV_K8S_SAMPLE/output/weblogic-domains/$NS_NAME
cd $K8S_DOMAIN_HOME/$NS_NAME
echo "Input >>>"
echo "kubectl create -f domain.yaml -- wait"
echo ""
echo ""
echo "Output <<<"
echo "kubectl create -f domain.yaml "
kubectl create -f domain.yaml 
echo ""
echo ""
echo ""
echo "Weblogic Domain created on persistance volume"
sleep 5

