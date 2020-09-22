#!/bin/bash
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains
export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts

source $OCI_VM_K8S/env.sh

export NS_NAME=$1

clear
$SCRIPT_HOME/header.sh
echo " "
echo " "
echo "Step 1 - Cloning"
echo "Git K8s Opr "
echo " "
echo " "
echo "git clone weblogic kubernetes operator...."
sleep 5
sudo yum install git
cd $HOME
rm -rf weblogic-kubernetes-operator
echo "git clone https://github.com/oracle/weblogic-kubernetes-operator.git"
git clone https://github.com/oracle/weblogic-kubernetes-operator.git
echo "Successfully installed weblogic kubernetes operator"
echo "==================================================="
cd -
sleep 2
