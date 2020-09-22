#!/bin/bash
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
source $OCI_VM_K8S/env.sh
export NS_NAME=$1
echo " "
echo " "
clear
$SCRIPT_HOME/header.sh
echo "Create db service"
echo "========================================="
echo " "
echo " "
cd $DB_SAMPLE
echo " "
echo ""
echo ""
echo "Input >>>"
echo "./start-db-service.sh -s docker-store -n $NS_NAME-ns"
echo ""
echo ""
echo "Output <<<"
./start-db-service.sh -s docker-store -n $NS_NAME-ns
echo ""
echo ""
echo ""
echo ""
clear
$SCRIPT_HOME/header.sh
echo "kubectl get all -n $NS_NAME-ns|grep oracle-db"
kubectl get all -n $NS_NAME-ns|grep oracle-db
echo " "
echo " "
echo " "
echo "DB service created Successfully!!!"
sleep 5

