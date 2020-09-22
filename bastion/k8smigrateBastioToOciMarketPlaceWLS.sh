#!/bin/bash

SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
DOMAIN_CONFIG=$SCRIPT_HOME/domains

OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
export BASTION_HOME=$SCRIPT_HOME/bastion

cd $SCRIPT_HOME


SSH=/usr/bin/ssh
SCP=/usr/bin/scp
# ./migrateOnPremToBastionWLS.sh <ORACLE_HOME> <DOMAIN_HOME> <EXPORT_FILENAME>
# ./migrateOnPremToBastionWLS.sh /home/opc/wls/oracle_home /home/opc/wls/oracle_home/user_projects/domains/winDomain winDomain

read -p "Enter your on-prem domain name you want use : " BASTION_DOMAIN_NAME
BASTION_DOMAIN_HOME=$BASTION_HOME/output/$BASTION_DOMAIN_NAME
echo ""
echo ""
read -p "Enter wls domain on k8s cluster you want to upgrade : " MKT_DOMAIN_NAME
MKT_DOMAIN_HOME=/shared/domains/$MKT_DOMAIN_NAME
echo ""
echo ""
ORACLE_HOME=/u01/oracle

read -p "You will be prompted to makes changes to the files, please Y to continue Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
  vi $BASTION_DOMAIN_HOME/$BASTION_DOMAIN_NAME-onprem.yaml $BASTION_DOMAIN_HOME/$BASTION_DOMAIN_NAME-onprem.properties
else
   echo " skipping modifying the files"
   #$SCRIPT_HOME/wls-migrate.sh
   #exit;
fi
REMOTE_IP=`kubectl get pods -o wide --sort-by={.spec.nodeName} -n $MKT_DOMAIN_NAME-ns| grep admin |awk '{print $7}'`
echo ""
echo ""
echo "IP Address of Admin server: " $REMOTE_IP
echo ""
read -p "Enter linux user on the remote machine running weblogic: " REMOTE_USER
echo ""
echo ""
read -p "Enter shared kube directory on your PV : " KUBE_DIR
clear
echo "Below is the details:"
echo "====================="
echo ""
echo "Oracle Home:  "$ORACLE_HOME
echo "On Prem Domain:  "$BASTION_DOMAIN_HOME
echo "OCI MARKETPLACE Domain:  "$MKT_DOMAIN_HOME
echo "Shared kube directory on PV:  "$KUBE_DIR
echo ""
echo "ssh details"
echo $REMOTE_USER@$REMOTE_IP
echo ""
echo ""
ADMIN_HOST=`kubectl get pods -n $MKT_DOMAIN_NAME-ns |grep admin|grep Running | awk '{print $1}'`
BASTION_HOME=/shared/bastion
JAVA_HOME=$BASTION_HOME/jdk
read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    rm $BASTION_DOMAIN_HOME/update.sh
    COMMANDS=" -oracle_home $ORACLE_HOME -domain_home $MKT_DOMAIN_HOME -archive_file /shared/$BASTION_DOMAIN_NAME/$BASTION_DOMAIN_NAME-onprem.zip -model_file /shared/$BASTION_DOMAIN_NAME/$BASTION_DOMAIN_NAME-onprem.yaml -variable_file /shared/$BASTION_DOMAIN_NAME/$BASTION_DOMAIN_NAME-onprem.properties -admin_url t3://$ADMIN_HOST:7001"
    echo "export JAVA_HOME=$BASTION_HOME/jdk;" > $BASTION_DOMAIN_HOME/update.sh
    echo "export BASTION_HOME=/shared/bastion;" >>  $BASTION_DOMAIN_HOME/update.sh
    echo "$BASTION_HOME/weblogic-deploy/bin/updateDomain.sh $COMMANDS;" >> $BASTION_DOMAIN_HOME/update.sh

    $SCP -r bastion/bastion.zip $REMOTE_USER@$REMOTE_IP:$KUBE_DIR;
    $SCP -r $BASTION_DOMAIN_HOME $REMOTE_USER@$REMOTE_IP:$KUBE_DIR;

    read -p "If you have wallet you need to upload Y [Y/N]: " useroption
    if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
       read -p "Enter wallet location: " walletlocation
       $SCP -r $walletlocation $REMOTE_USER@$REMOTE_IP:$KUBE_DIR;
    fi

    $SSH $REMOTE_USER@$REMOTE_IP /bin/bash  << EOF
    cd $KUBE_DIR
    rm -rf bastion
    unzip bastion.zip
    chmod 777 $KUBE_DIR/$BASTION_DOMAIN_NAME/update.sh
EOF
    echo "kubectl exec -it $MKT_DOMAIN_NAME-admin-server -n $MKT_DOMAIN_NAME-ns -- /bin/bash"
    echo ""
    echo ""
    echo "========================================"
    echo ""
    echo " Run below commands:"
    echo ""
    echo "$ /shared/$BASTION_DOMAIN_NAME/update.sh"
    echo ""
    echo "========================================="
    kubectl exec -it $MKT_DOMAIN_NAME-admin-server -n $MKT_DOMAIN_NAME-ns -- /bin/bash
else
   $SCRIPT_HOME/wls-migrate.sh
   exit;
fi
