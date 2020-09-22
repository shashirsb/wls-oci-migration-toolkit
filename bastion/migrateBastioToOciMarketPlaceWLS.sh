#!/bin/bash -x

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
MKT_DOMAIN_HOME=/u01/data/domains/$MKT_DOMAIN_NAME
echo ""
echo ""
ORACLE_HOME=/u01/app/oracle/middleware

read -p "You will be prompted to makes changes to the files, please Y to continue Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
  vi $BASTION_DOMAIN_HOME/$BASTION_DOMAIN_NAME-onprem.yaml $BASTION_DOMAIN_HOME/$BASTION_DOMAIN_NAME-onprem.properties
else
   echo "skipping modifying the files"
   #$SCRIPT_HOME/wls-migrate.sh
   #exit;
fi

echo ""
echo ""
read -p "Enter IP Address of Admin server: " REMOTE_IP
echo ""
echo ""
read -p "Enter Port  of Admin server: " ADMIN_PORT
echo ""
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
    rm $BASTION_DOMAIN_HOME/update.sh
    COMMANDS=" -oracle_home $ORACLE_HOME -domain_home $MKT_DOMAIN_HOME -archive_file /u01/migration/$BASTION_DOMAIN_NAME/$BASTION_DOMAIN_NAME-onprem.zip -model_file /u01/migration/$BASTION_DOMAIN_NAME/$BASTION_DOMAIN_NAME-onprem.yaml -variable_file /u01/migration/$BASTION_DOMAIN_NAME/$BASTION_DOMAIN_NAME-onprem.properties -admin_url t3://$REMOTE_IP:$ADMIN_PORT"
    echo "export BASTION_HOME=/u01/migration/bastion;" >>  $BASTION_DOMAIN_HOME/update.sh
    echo "/u01/migration/bastion/weblogic-deploy/bin/updateDomain.sh $COMMANDS;" >> $BASTION_DOMAIN_HOME/update.sh

    $SCP -r bastion/bastion.zip $REMOTE_USER@$REMOTE_IP:/home/$REMOTE_USER;
    $SCP -r $BASTION_DOMAIN_HOME $REMOTE_USER@$REMOTE_IP:/home/$REMOTE_USER;

    read -p "If you have wallet you need to upload Y [Y/N]: " useroption
    if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
       read -p "Enter wallet location: " walletlocation
       echo ""
       read -p "Enter all the managed server IP with space e.g., 127.0.0.1 127.0.0.2:- " MANAGED_IPS
        #IP="123.2.3.23 123.45.32.123"
	values=($MANAGED_IPS)
	for i in "${values[@]}"; do
	  echo "$i";
	  $SCP -r $walletlocation $REMOTE_USER@$i:/home/$REMOTE_USER;
          $SSH $REMOTE_USER@$i ' hostname && sudo rm -rf /u01/migration &&  sudo mkdir /u01/migration && sudo mv '$walletlocation' /u01/migration/ &&  sudo chown -R oracle:oracle /u01/migration  && hostname'
          hostname;
	done
      #$SCP -r $walletlocation $REMOTE_USER@$REMOTE_IP:/home/$REMOTE_USER;

    fi

    $SSH $REMOTE_USER@$REMOTE_IP /bin/bash  << EOF
    rm -rf bastion
    unzip bastion.zip
    export JAVA_HOME=$BASTION_HOME/jdk
    export BASTION_HOME=$HOME/bastion
    chmod 777 /home/$REMOTE_USER/$BASTION_DOMAIN_NAME/update.sh
    sudo mv * /u01/migration/
    sudo chown -R oracle:oracle /u01/migration
    echo ""
    echo ""
    echo "========================================"
    echo ""
    echo " Run below commands:"
    echo ""
    echo "$ sudo su oracle"
    echo "$ /u01/migration/airflow/update.sh"
    echo ""
    echo "========================================="
EOF
    $SSH $REMOTE_USER@$REMOTE_IP
else
   $SCRIPT_HOME/wls-migrate.sh
   exit;
fi
