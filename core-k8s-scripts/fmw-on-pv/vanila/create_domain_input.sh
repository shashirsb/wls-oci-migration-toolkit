#!/bin/bash -x
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
source $OCI_VM_K8S//env.sh
export NS_NAME=$1
echo " "
echo " "
echo "Create Domain on PV in  Kubernetes cluster"
echo "========================================="
echo " "
echo " "
cd $PV_K8S_SOA_SAMPLE
echo "Input >>>"
echo "./create-domain.sh  -i create-domain-inputs.yaml -o output"
echo ""
echo ""
echo "Output <<<"
./create-domain.sh  -i create-domain-inputs.yaml -o output
echo ""
echo ""
echo ""
echo ""
sleep 5

