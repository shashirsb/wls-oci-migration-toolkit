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
echo ""
echo ""
echo "Create rcu credentials"
echo "========================================="
echo " "
echo " "
cd $RCU_CREDENTIALS_SAMPLE

echo " "
echo ""
echo ""
echo "Input >>>"
echo "./create-rcu-credentials.sh -u SOA1 -p Oradoc_db1 -a sys -q Oradoc_db1 -d $NS_NAME -n $NS_NAME-ns -s $NS_NAME-rcu-credentials"
echo ""
echo ""
echo "Output <<<"
./create-rcu-credentials.sh -u SOA1 -p Oradoc_db1 -a sys -q Oradoc_db1 -d $NS_NAME -n $NS_NAME-ns -s $NS_NAME-rcu-credentials
echo ""
echo ""
echo ""
echo ""
sleep 2
clear
$SCRIPT_HOME/header.sh
cd $RCU_SCHEMA_SAMPLE
echo " "
echo ""
echo "Input >>>"
echo "./create-image-pull-secret.sh  -u $ORCL_CONTAINER_USERNAME  -p $ORCL_CONTAINER_PASSWORD -e $ORCL_CONTAINER_EMAIL"
echo ""
echo ""
echo "Output <<<"
./create-image-pull-secret.sh  -u $ORCL_CONTAINER_USERNAME  -p $ORCL_CONTAINER_PASSWORD -e $ORCL_CONTAINER_EMAIL
echo ""
echo ""
echo ""
echo "Input >>>"
echo "./create-rcu-schema.sh -s SOA1 -t soaessosb -d oracle-db.$NS_NAME-ns.svc.cluster.local:1521/devpdb.k8s -p docker-store -i container-registry.oracle.com/middleware/soasuite:12.2.1.3 -p docker-store"
echo ""
echo "Output <<<"
./create-rcu-schema.sh -s SOA1 -t soaessosb -d oracle-db.$NS_NAME-ns.svc.cluster.local:1521/devpdb.k8s -p docker-store -i container-registry.oracle.com/middleware/soasuite:12.2.1.3 
echo ""
echo ""
echo ""
echo ""
sleep 2
$SCRIPT_HOME/header.sh
clear
echo " "
echo " "
echo "RCU created Successfully!!!"
sleep 5
