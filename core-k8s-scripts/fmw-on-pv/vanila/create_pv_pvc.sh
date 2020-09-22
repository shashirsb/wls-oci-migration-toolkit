#!/bin/bash -x
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
source $OCI_VM_K8S/env.sh
export NS_NAME=$1
echo " "
echo " "
echo "Create PV and PVC  on Kubernetes"
echo "========================================="
echo " "
echo " "
cd $PV_K8S_SAMPLE
echo "Input >>>"
echo "./create-pv-pvc.sh -i create-pv-pvc-inputs.yaml -o outpu"
echo ""
echo ""
echo "Output <<<"
./create-pv-pvc.sh -i create-pv-pvc-inputs.yaml -o output
echo ""
echo ""
echo ""
echo ""
cd output/pv-pvcs
echo "kubectl create -f $NS_NAME-$NS_NAME-pv.yaml -n $NS_NAME-ns"
echo "kubectl create -f $NS_NAME-$NS_NAME-pvc.yaml -n $NS_NAME-ns"
kubectl create -f $NS_NAME-$NS_NAME-pv.yaml -n $NS_NAME-ns
kubectl create -f $NS_NAME-$NS_NAME-pvc.yaml -n $NS_NAME-ns
echo ""
echo ""
echo ""
echo "kubectl describe -f $NS_NAME-$NS_NAME-pv.yaml -n $NS_NAME-ns"
echo "kubectl describe -f $NS_NAME-$NS_NAME-pvc.yaml -n $NS_NAME-ns"
kubectl describe -f $NS_NAME-$NS_NAME-pv.yaml -n $NS_NAME-ns
kubectl describe -f $NS_NAME-$NS_NAME-pvc.yaml -n $NS_NAME-ns

echo " "
echo " "
echo " "
echo "Persistance Volume and  Claim created Successfully!!!"
sleep 5

