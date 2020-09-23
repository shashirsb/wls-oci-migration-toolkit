#!/bin/bash  

SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
DOMAIN_CONFIG=$SCRIPT_HOME/domains

OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts

cd $SCRIPT_HOME


SSH=/usr/bin/ssh
SCP=/usr/bin/scp
# ./migrateOnPremToBastionWLS.sh <ORACLE_HOME> <DOMAIN_HOME> <EXPORT_FILENAME>
# ./migrateOnPremToBastionWLS.sh /home/opc/wls/oracle_home /home/opc/wls/oracle_home/user_projects/domains/winDomain winDomain
read -p "Enter your remote domain name you want to pack: " DOMAIN_NAME
mkdir -p $BASTION_HOME/output/$DOMAIN_NAME
echo ""
echo ""
echo "Oracle home e.g. /home/opc/wls/oracle_home"
read -p "Enter oracle home path: " ORACLE_HOME
echo ""
echo ""
echo "Domain home e.g. /home/opc/wls/oracle_home/user_projects/domains"
read -p "Enter your remote domain path: " DOMAIN_HOME
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
echo "Domain Home:  "$DOMAIN_HOME
echo "Domain Name:  "$DOMAIN_HOME/$DOMAIN_NAME
echo ""
echo "ssh details"
echo $REMOTE_USER@$REMOTE_IP
echo ""
echo ""
echo ""
echo ""
echo " If you want to run the discovery tool manually please follow the below instruction"
echo ""
echo "1. Download weblogic-deploy.zip tool and unzip the file , reference: https://github.com/oracle/weblogic-deploy-tooling/releases/latest"
echo "2. Set JAVA_HOME"
echo "3. Run the command : "
echo "        ~/weblogic-deploy/bin/discoverDomain.sh  \ "
echo "        -oracle_home $ORACLE_HOME \ " 
echo "        -domain_home $DOMAIN_HOME/$DOMAIN_NAME \ " 
echo "        -archive_file $BASTION_HOME/output/$DOMAIN_NAME/$DOMAIN_NAME-onprem.zip \ "
echo "        -model_file $BASTION_HOME/output/$DOMAIN_NAME/$DOMAIN_NAME-onprem.yaml"

echo "4. Copy the folder with the name $DOMAIN_NAME containing $DOMAIN_NAME-onprem.zip $DOMAIN_NAME-onprem.yaml $DOMAIN_NAME-onprem.properties from on-prem server/VM into $HOME/wls-oci-migration-toolkit/bastion/output/"
echo ""
echo ""

BASTION_HOME=/home/$REMOTE_USER/bastion
JAVA_HOME=$BASTION_HOME/jdk

read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then

    $SCP  $SCRIPT_HOME/bastion/bastion.zip $REMOTE_USER@$REMOTE_IP:/home/$REMOTE_USER;

    COMMANDS=" -oracle_home $ORACLE_HOME -domain_home $DOMAIN_HOME/$DOMAIN_NAME -archive_file $BASTION_HOME/output/$DOMAIN_NAME/$DOMAIN_NAME-onprem.zip -model_file $BASTION_HOME/output/$DOMAIN_NAME/$DOMAIN_NAME-onprem.yaml"

   $SSH $REMOTE_USER@$REMOTE_IP /bin/bash -x << EOF
   rm -rf bastion
   unzip bastion.zip
   export JAVA_HOME=$BASTION_HOME/jdk
   export BASTION_HOME=$HOME/bastion
   mkdir -p $BASTION_HOME/output/$DOMAIN_NAME
   $BASTION_HOME/weblogic-deploy/bin/discoverDomain.sh $COMMANDS
EOF
   scp -r $REMOTE_USER@$REMOTE_IP:/home/$REMOTE_USER/bastion/output/$DOMAIN_NAME $SCRIPT_HOME/bastion/output
else
   $SCRIPT_HOME/wls-migrate.sh
   exit;
fi

echo ""
echo "Please see the on-prem domain packed details"
echo "============================================"
echo ""
echo "Command run on premise: $BASTION_HOME/weblogic-deploy/bin/discoverDomain.sh $COMMANDS"
echo ""
echo ""
echo "Domain Name: $DOMAIN_NAME"
ls -ltr $SCRIPT_HOME/bastion/output/$DOMAIN_NAME
echo ""
echo ""
read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
   $SCRIPT_HOME/wls-migrate.sh option_k8s_1_onprem_pack
else
   $SCRIPT_HOME/wls-migrate.sh
   exit;
fi



