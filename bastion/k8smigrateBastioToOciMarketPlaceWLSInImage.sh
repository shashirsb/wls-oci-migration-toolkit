#!/bin/bash  

SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
DOMAIN_CONFIG=$SCRIPT_HOME/domains

OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
export BASTION_HOME=$SCRIPT_HOME/bastion
REMOTE_KUBE_DIR=/u01/migration

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
echo ""
echo ""
echo "Enter oracle home for k8s cluster you want to upgrade "
echo "e.g. /u01/oracle "
echo ""
read -p "Oracle home: " ORACLE_HOME
echo ""
echo ""
echo "Enter wls domain home for k8s cluster you want to upgrade "
echo "e.g. /u01/oracle/user_projects/domains "
echo ""
read -p "Domain home: " MKT_DOMAIN_HOME
echo ""
echo ""
MKT_DOMAIN_HOME=$MKT_DOMAIN_HOME/$MKT_DOMAIN_NAME
#ORACLE_HOME=/u01/oracle

read -p "You will be prompted to makes changes to the files, please Y to continue Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
  vi $BASTION_DOMAIN_HOME/$BASTION_DOMAIN_NAME-onprem.yaml $BASTION_DOMAIN_HOME/$BASTION_DOMAIN_NAME-onprem.properties
else
   echo " skipping modifying the files"
   #$SCRIPT_HOME/wls-migrate.sh
   #exit;
fi
#REMOTE_IP=`kubectl get pods -o wide --sort-by={.spec.nodeName} -n $MKT_DOMAIN_NAME-ns| grep admin |awk '{print $7}'`
#echo ""
#echo ""
#echo "IP Address of Admin server: " $REMOTE_IP
#echo ""
#read -p "Enter linux user on the remote machine running weblogic: " REMOTE_USER
echo ""
echo ""
clear
echo "Below is the details:"
echo "====================="
echo ""
echo "Oracle Home:  "$ORACLE_HOME
echo "On Prem Domain:  "$BASTION_DOMAIN_HOME
echo "OCI Kubernetes WLS Domain:  "$MKT_DOMAIN_HOME
echo ""
#echo "ssh details"
#echo $REMOTE_USER@$REMOTE_IP
echo ""
echo ""
ADMIN_HOST=`kubectl get pods -n $MKT_DOMAIN_NAME-ns |grep admin|grep Running | awk '{print $1}'`
BASTION_HOME=$REMOTE_KUBE_DIR/bastion
JAVA_HOME=$BASTION_HOME/jdk
read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    rm $BASTION_DOMAIN_HOME/update.sh
    COMMANDS=" -oracle_home $ORACLE_HOME -domain_home $MKT_DOMAIN_HOME -archive_file $REMOTE_KUBE_DIR/$BASTION_DOMAIN_NAME/$BASTION_DOMAIN_NAME-onprem.zip -model_file $REMOTE_KUBE_DIR/$BASTION_DOMAIN_NAME/$BASTION_DOMAIN_NAME-onprem.yaml -variable_file $REMOTE_KUBE_DIR/$BASTION_DOMAIN_NAME/$BASTION_DOMAIN_NAME-onprem.properties -admin_url t3://$ADMIN_HOST:7001"
    echo "export JAVA_HOME=$BASTION_HOME/jdk;" > $BASTION_DOMAIN_HOME/update.sh 
    echo "export BASTION_HOME=$REMOTE_KUBE_DIR/bastion;" >>  $BASTION_DOMAIN_HOME/update.sh
    echo "$BASTION_HOME/weblogic-deploy/bin/updateDomain.sh $COMMANDS;" >> $BASTION_DOMAIN_HOME/update.sh
   
    kubectl exec -it $MKT_DOMAIN_NAME-admin-server -n $MKT_DOMAIN_NAME-ns -- sh -c 'mkdir -p '$REMOTE_KUBE_DIR
    echo " Setting up weblogic deploy tool... please wait"
    kubectl  cp bastion/bastion $MKT_DOMAIN_NAME-admin-server:$REMOTE_KUBE_DIR/ -n $MKT_DOMAIN_NAME-ns
    echo " Copying On-prem details... please wait"
    kubectl  cp $BASTION_DOMAIN_HOME $MKT_DOMAIN_NAME-admin-server:$REMOTE_KUBE_DIR/ -n $MKT_DOMAIN_NAME-ns
    echo ""
    echo ""


    read -p "If you have wallet you need to upload Y [Y/N]: " useroption
    if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
       read -p "Enter wallet location: " walletlocation
       kubectl  cp $walletlocation $MKT_DOMAIN_NAME-admin-server:$REMOTE_KUBE_DIR/ -n $MKT_DOMAIN_NAME-ns
    fi

    kubectl exec -i $MKT_DOMAIN_NAME-admin-server -n $MKT_DOMAIN_NAME-ns -- sh -c cd $REMOTE_KUBE_DIR
    kubectl exec -i $MKT_DOMAIN_NAME-admin-server -n $MKT_DOMAIN_NAME-ns -- sh -c 'chmod 777 '$REMOTE_KUBE_DIR/$BASTION_DOMAIN_NAME/update.sh

    echo "kubectl exec -it $MKT_DOMAIN_NAME-admin-server -n $MKT_DOMAIN_NAME-ns -- /bin/bash"
    echo ""
    echo ""
    echo "========================================================="
    echo ""
    echo " You are now inside docker container running Admin Server"
    echo " pod/$MKT_DOMAIN_NAME-admin-server"
    echo ""
    echo " Run below commands:"
    echo ""
    echo "$ $REMOTE_KUBE_DIR/$BASTION_DOMAIN_NAME/update.sh"
    echo ""
    echo "=========================================================="
    kubectl exec -it $MKT_DOMAIN_NAME-admin-server -n $MKT_DOMAIN_NAME-ns -- /bin/bash
else
   $SCRIPT_HOME/wls-migrate.sh
   exit;
fi

