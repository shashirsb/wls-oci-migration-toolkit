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
read -p "Enter wls domain on oci marketplace you want to upgrade : " MKT_DOMAIN_NAME
MKT_DOMAIN_HOME=/home/opc/wls/oracle_home/user_projects/domains/$MKT_DOMAIN_NAME
echo ""
echo ""
ORACLE_HOME=/home/opc/wls/oracle_home

read -p "You will be prompted to makes changes to the files, please Y to continue Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
  vi $BASTION_DOMAIN_HOME/$BASTION_DOMAIN_NAME-onprem.yaml $BASTION_DOMAIN_HOME/$BASTION_DOMAIN_NAME-onprem.properties
else
   $SCRIPT_HOME/wls-migrate.sh
   exit;
fi

echo ""
echo ""
read -p "Enter IP Address of Admin server: " REMOTE_IP
echo ""
read -p "Enter linux user on the remote machine running weblogic: " REMOTE_USER
echo ""
echo ""
clear
echo "Below is the details:"
echo "====================="
echo ""
echo "Oracle Home:  "$ORACLE_HOME
echo "On Prem Domain:  "$BASTION_DOMAIN_HOME
echo "OCI MARKETPLACE Domain:  "$MKT_DOMAIN_HOME
echo ""
echo "ssh details"
echo $REMOTE_USER@$REMOTE_IP
echo ""
echo ""

BASTION_HOME=/home/$REMOTE_USER/bastion
JAVA_HOME=$BASTION_HOME/jdk
read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    #SSH $REMOTE_USER@$REMOTE_IP mkdir -p $BASTION_HOME $BASTION_HOME/output;
#    $SCP -r bastion/bastion.zip $REMOTE_USER@$REMOTE_IP:/home/$REMOTE_USER;
#    $SCP -r $BASTION_DOMAIN_HOME $REMOTE_USER@$REMOTE_IP:/home/$REMOTE_USER;
#    #$SCP -r bastion/jdk $REMOTE_USER@$REMOTE_IP:/$BASTION_HOME;

    COMMANDS=" -oracle_home $ORACLE_HOME -domain_home $MKT_DOMAIN_HOME -archive_file /home/$REMOTE_USER/$BASTION_DOMAIN_NAME/$BASTION_DOMAIN_NAME-onprem.zip -model_file /home/$REMOTE_USER/$BASTION_DOMAIN_NAME/$BASTION_DOMAIN_NAME-onprem.yaml -variable_file /home/$REMOTE_USER/$BASTION_DOMAIN_NAME/$BASTION_DOMAIN_NAME-onprem.properties -admin_url t3://150.136.101.165:7001"
    echo "export JAVA_HOME=$BASTION_HOME/jdk;" > $BASTION_DOMAIN_HOME/update.sh 
    echo "export BASTION_HOME=$HOME/bastion;" >>  $BASTION_DOMAIN_HOME/update.sh
    echo "$BASTION_HOME/weblogic-deploy/bin/updateDomain.sh $COMMANDS;" >> $BASTION_DOMAIN_HOME/update.sh
    
    $SCP -r bastion/bastion.zip $REMOTE_USER@$REMOTE_IP:/home/$REMOTE_USER;
    $SCP -r $BASTION_DOMAIN_HOME $REMOTE_USER@$REMOTE_IP:/home/$REMOTE_USER;

    $SSH $REMOTE_USER@$REMOTE_IP /bin/bash -x << EOF
    rm -rf bastion
    unzip bastion.zip
    export JAVA_HOME=$BASTION_HOME/jdk
    export BASTION_HOME=$HOME/bastion
    chmod 777 /home/$REMOTE_USER/$BASTION_DOMAIN_NAME/update.sh
EOF
    $SSH $REMOTE_USER@$REMOTE_IP  
else
   $SCRIPT_HOME/wls-migrate.sh
   exit;
fi

