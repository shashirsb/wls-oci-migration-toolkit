#!/bin/bash 

header () {
echo ""
echo ""
echo "		============================== ORACLE CORPORATION ================================="
echo "		=									          ="
echo "		=	SEHUB, MODERN APPLICATION DEVELOPMENT TEAM				  ="
echo "		=	Author: Shashi Bhushan Ramachandra					  ="
echo "		=	Email:  shashi.bhushan.ramachandra@oracle.com				  ="
echo "		=                                                                                 ="
echo "		=                                                                                 ="
echo "		==================================================================================="
echo ""
echo ""
echo ""
}

export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
export BASTION_HOME=$SCRIPT_HOME/bastion

cd $SCRIPT_HOME

export SELECTED_FUNCTION=$1
option_main () {

if [ $SELECTED_FUNCTION == 'option_k8s_1_onprem_pack' ]; then
   export SELECTED_FUNCTION=""
   option_k8s_1_onprem_pack
elif [ $SELECTED_FUNCTION == 'option_k8s_3_install_software' ]; then
   export SELECTED_FUNCTION=""
   option_k8s_3_install_software
elif [ $SELECTED_FUNCTION == 'option_k8s_4_wls_vanila' ]; then
   export SELECTED_FUNCTION=""
   option_k8s_4_wls_vanila
elif [ $SELECTED_FUNCTION == 'option_k8s_5_wls_custom' ]; then
   export SELECTED_FUNCTION=""
   option_k8s_5_wls_custom
elif [ $SELECTED_FUNCTION == 'header' ]; then
   header
fi


clear
header
echo ""
echo " Please select on of the below option"
echo ""
#echo " 1. Migrate to OCI VM Instances "
echo " 1. OCI Kubernetes cluster "
echo " 2. Exit "
echo ""
echo ""
read -p "Enter your option? [1, 2]: " useroption
#if [ $useroption == '1' ]; then
#   echo "Migrating to VM on OCI"
#   option_mig_to_oci
#el
if [ $useroption == '1' ]; then
   echo "Oracle Kubernetes"
   option_mig_to_k8s
elif [ $useroption == '2' ]; then
   exit
else
   echo ""
   echo "Wrong input, Please enter a valid response..........";
   sleep 1
   option_main
fi
echo ""
echo ""
}

option_mig_to_oci () {
 $OCI_VM_SCRIPT/liftnshift2.sh
}


option_mig_to_k8s (){
 clear
 header
 echo ""
 echo "==========================================="
 echo "          KUBERNETES CLUSTER SETUP"
 echo "==========================================="
echo ""
echo " Please select on of the below option"
echo ""
echo " 1. Migrate on-prem wls domain to cloud using WDT "
echo " 2. Create docker image with wls domain"
echo " 3. Install k8s pre-requisites software"
echo " 4. Weblogic Vanila"
echo " 5. Weblogic Custom/On-prem Domain"
echo " 6. Weblogic Vanila on Persistenace volume (PV)"
echo " 7. Weblogic Custom/on-prem Domain on Persistenace volume (PV)"
echo " 8. SOA/OSB/FMW vanila Domain on Persistance Volume (PV)"
echo " 9. SOA/OSB/FMW Custom Domain on Persistance Volume (PV)"
echo " 10. Go to Main Menu"
echo " 11. Exit "
echo ""
echo ""
read -p "Enter your option? [1, 2, 3, 4, 5, 8 or 7]: " useroption
if [ $useroption == '1' ]; then 
   option_k8s_1_onprem_pack 
elif [ $useroption == '2' ]; then
   option_k8s_2_custom_docker_img
elif [ $useroption == '3' ]; then
   option_k8s_3_install_software
elif [ $useroption == '4' ]; then
   option_k8s_4_wls_vanila
elif [ $useroption == '5' ]; then
   option_k8s_5_wls_custom
elif [ $useroption == '6' ]; then
   option_k8s_6_wls_vanila_on_pv
elif [ $useroption == '7' ]; then
   option_k8s_7_wls_custom_on_pv 
elif [ $useroption == '10' ]; then
   option_main
elif [ $useroption == '11' ]; then
   exit
else
echo ""
   echo "Wrong input, Please enter a valid response..........";
   sleep 1
   option_mig_to_k8s
fi
echo ""
echo ""
}

option_k8s_1_onprem_pack () {
clear
 header
 echo ""
 echo "================================================"
 echo "          KUBERNETES CLUSTER SETUP"
 echo "  Option1: Migration onprem wls domain using WDT"
 echo "================================================"
echo ""
echo " Please select on of the below option"
echo ""
echo " 1. List migrated on-prem wls domains "
echo " 2. Pack a onprem wls domain"
echo " 3. Update wls on VM with on-prem domain"
echo " 4. Update OCI marketplace with on-prem domain"
echo " 5. Update k8s cluster with on-prem domain"
echo " 6. Go to Weblogic on Kubernetes Cluster Menu"
echo " 7. Go to Main Menu"
echo " 8. Exit "
echo ""
echo ""
read -p "Enter your option? [1, 2, 3, 4 or 5]: " useroption
if [ $useroption == '1' ]; then
   $BASTION_HOME/listOnPremdomains.sh
elif [ $useroption == '2' ]; then
   $BASTION_HOME/migrateOnPremToBastionWLS.sh
elif [ $useroption == '3' ]; then
   $BASTION_HOME/migrateBastioToOciVmWLS.sh
elif [ $useroption == '4' ]; then
   $BASTION_HOME/migrateBastioToOciMarketPlaceWLS.sh
elif [ $useroption == '5' ]; then
   option_k8s_1_onprem_pack_select_k8s_type
 elif [ $useroption == '6' ]; then
   option_mig_to_k8s
elif [ $useroption == '7' ]; then
   option_main
elif [ $useroption == '8' ]; then
   exit
else
echo ""
   echo "Wrong input, Please enter a valid response..........";
   sleep 1
   option_k8s_1_onprem_pack
fi
echo ""
echo ""

}

option_k8s_1_onprem_pack_select_k8s_type () {
   clear
 header
 echo ""
 echo "================================================"
 echo "          KUBERNETES CLUSTER SETUP"
 echo "  Option1: Migration onprem wls domain using WDT"
 echo "================================================="
echo ""
echo " Please select on of the below option"
echo ""
echo " 1. Domain in Image"
echo " 2. Domain on PV"
echo " 3. Go to K8s Menu"
echo " 4. Go to Main Menu"
echo " 5. Exit "
echo ""
echo ""
read -p "Enter your option? [1, 2, 3 or 4]: " useroption
if [ $useroption == '1' ]; then
   $BASTION_HOME/k8smigrateBastioToOciMarketPlaceWLSInImage.sh
 elif [ $useroption == '2' ]; then
   $BASTION_HOME/k8smigrateBastioToOciMarketPlaceWLS.sh
   option_mig_to_k8s
 elif [ $useroption == '3' ]; then
   option_mig_to_k8s
elif [ $useroption == '4' ]; then
   option_main
elif [ $useroption == '5' ]; then
   exit
else
echo ""
   echo "Wrong input, Please enter a valid response..........";
   sleep 1
   option_k8s_2_custom_docker_img
fi
echo ""
echo ""
}
option_k8s_2_custom_docker_img () {
   clear
 header
 echo ""
 echo "==========================================="
 echo "          KUBERNETES CLUSTER SETUP"
 echo "  Option2: Create custom docker wls image  "
 echo "==========================================="
echo ""
echo " Please select on of the below option"
echo ""
echo " 1. Create docker image of wls domain"
echo " 2. Go to K8s Menu"
echo " 3. Go to Main Menu"
echo " 4. Exit "
echo ""
echo ""
read -p "Enter your option? [1, 2, 3 or 4]: " useroption
if [ $useroption == '1' ]; then
   $OCI_VM_K8S/create-docker-image/custom/trigger.sh
 elif [ $useroption == '2' ]; then
   option_mig_to_k8s
elif [ $useroption == '3' ]; then
   option_main
elif [ $useroption == '4' ]; then
   exit
else
echo ""
   echo "Wrong input, Please enter a valid response..........";
   sleep 1
   option_k8s_2_custom_docker_img
fi
echo ""
echo ""
}

option_k8s_3_install_software () {
KUBECTL_VERSION=`kubectl version --client|awk '{print $5 "" $9}'`
HELM_VERSION=`helm version|awk '{print $1}'|cut -c19-34`
PYTHON_VERSION=$(python --version  2>&1)
DOCKER_VERSION=`docker version --format '{{.Server.Version}}'`

clear
 header
 echo ""
 echo "==========================================="
 echo "          KUBERNETES CLUSTER SETUP         "
 echo "          Option3: Install software        "
 echo "==========================================="
echo ""
echo " Please select on of the below option"
echo ""
echo " 1. Install python3 $PYTHON_VERSION"
echo " 2. Install kubectl $KUBECTL_VERSION"
echo " 3. Install helm  $HELM_VERSION"
echo " 4. Install docker $DOCKER_VERSION"
echo " 5. Go to K8s Menu"
echo " 6. Go to Main Menu"
echo " 7. Exit "
echo ""
read -p "Enter your option? [1, 2, 3, 4 or 5]: " useroption
if [ $useroption == '1' ]; then
   $OCI_VM_K8S/installer/install_python3.sh
elif [ $useroption == '2' ]; then
   $OCI_VM_K8S/installer/install_kubectl.sh
elif [ $useroption == '3' ]; then
   $OCI_VM_K8S/installer/install_helm.sh
 elif [ $useroption == '4' ]; then
   $OCI_VM_K8S/installer/install_docker.sh  
elif [ $useroption == '5' ]; then
   option_mig_to_k8s 
elif [ $useroption == '6' ]; then
   option_main
elif [ $useroption == '7' ]; then
   exit
else
echo ""
   echo "Wrong input, Please enter a valid response..........";
   sleep 1
   option_k8s_3_install_software
fi
echo ""
}

option_k8s_4_wls_vanila  () {
export DOMAIN_TYPE=vanila
clear
 header
 echo ""
 echo "==========================================="
 echo "          KUBERNETES CLUSTER SETUP"
 echo "     Option4: K8s cluster with wls vanila  "
 echo "==========================================="
echo ""
echo " Please select on of the below option"
echo ""
echo " 1. Setup OCI config"
echo " 2. Setup OCIR/docker hub"
echo " 3. Setup kube config for k8s cluster"
echo " 4. Install wls vanilla to k8s cluster"
echo " 5. Go to K8s Menu"
echo " 6. Go to Main Menu"
echo " 7. Exit "
echo ""
echo ""
read -p "Enter your option? [1, 2, 3, 4, 5, 6 or 7]: " useroption
if [ $useroption == '1' ]; then
   $OCI_VM_K8S/common/oci_config_setup.sh
elif [ $useroption == '2' ]; then
   $OCI_VM_K8S/common/oci_config_setup.sh
elif [ $useroption == '3' ]; then
   $OCI_VM_K8S/common/kube_setup.sh
elif [ $useroption == '4' ]; then
   $OCI_VM_K8S/domain-in-image/vanila/trigger.sh
 elif [ $useroption == '5' ]; then
   option_mig_to_k8s
elif [ $useroption == '6' ]; then
   option_main
elif [ $useroption == '7' ]; then
   exit
else
echo ""
   echo "Wrong input, Please enter a valid response..........";
   sleep 1
   option_k8s_4_wls_vanila
fi
echo ""
}

option_k8s_5_wls_custom () {

}export DOMAIN_TYPE=custom
clear
 header
 echo ""
 echo "==========================================="
 echo "          KUBERNETES CLUSTER SETUP"
 echo "     Option4: K8s cluster with wls vanila  "
 echo "==========================================="
echo ""
echo " Please select on of the below option"
echo ""
echo " 1. Setup OCI config"
echo " 2. Setup OCIR/docker hub"
echo " 3. Setup kube config for k8s cluster"
echo " 4. Install wls custom to k8s cluster"
echo " 5. Go to K8s Menu"
echo " 6. Go to Main Menu"
echo " 7. Exit "
echo ""
echo ""
read -p "Enter your option? [1, 2, 3, 4, 5, 6 or 7]: " useroption
if [ $useroption == '1' ]; then
   $OCI_VM_K8S/common/oci_config_setup.sh
elif [ $useroption == '2' ]; then
   $OCI_VM_K8S/common/oci_config_setup.sh
elif [ $useroption == '3' ]; then
   $OCI_VM_K8S/common/kube_setup.sh
elif [ $useroption == '4' ]; then
   $OCI_VM_K8S/domain-in-image/custom/trigger.sh
 elif [ $useroption == '5' ]; then
   option_mig_to_k8s
elif [ $useroption == '6' ]; then
   option_main
elif [ $useroption == '7' ]; then
   exit
else
echo ""
   echo "Wrong input, Please enter a valid response..........";
   sleep 1
   option_k8s_5_wls_custom
fi
echo ""

}

option_k8s_6_wls_vanila_on_pv () {
export DOMAIN_TYPE=vanila
clear
 header
 echo ""
 echo "================================================"
 echo "          KUBERNETES CLUSTER SETUP"
 echo "     Option4: K8s cluster with wls vanila on pv "
 echo "================================================"
echo ""
echo " Please select on of the below option"
echo ""
echo " 1. Setup OCI config"
echo " 2. Setup OCIR/docker hub"
echo " 3. Setup kube config for k8s cluster"
echo " 4. Install wls vanilla on pv to k8s cluster"
echo " 5. Go to K8s Menu"
echo " 6. Go to Main Menu"
echo " 7. Exit "
echo ""
echo ""
read -p "Enter your option? [1, 2, 3, 4, 5, 6 or 7]: " useroption
if [ $useroption == '1' ]; then
   $OCI_VM_K8S/common/oci_config_setup.sh
elif [ $useroption == '2' ]; then
   $OCI_VM_K8S/common/oci_config_setup.sh
elif [ $useroption == '3' ]; then
   $OCI_VM_K8S/common/kube_setup.sh
elif [ $useroption == '4' ]; then
   $OCI_VM_K8S/domain-on-pv/vanila/trigger.sh
 elif [ $useroption == '5' ]; then
   option_mig_to_k8s
elif [ $useroption == '6' ]; then
   option_main
elif [ $useroption == '7' ]; then
   exit
else
echo ""
   echo "Wrong input, Please enter a valid response..........";
   sleep 1
   option_k8s_6_wls_vanila_on_pv
fi
echo ""
}

option_k8s_7_wls_custom_on_pv () {
export DOMAIN_TYPE=custom
clear
 header
 echo ""
 echo "================================================"
 echo "          KUBERNETES CLUSTER SETUP"
 echo "     Option4: K8s cluster with wls custom on pv "
 echo "================================================"
echo ""
echo " Please select on of the below option"
echo ""
echo " 1. Setup OCI config"
echo " 2. Setup OCIR/docker hub"
echo " 3. Setup kube config for k8s cluster"
echo " 4. Install wls custom on pv to k8s cluster"
echo " 5. Go to K8s Menu"
echo " 6. Go to Main Menu"
echo " 7. Exit "
echo ""
echo ""
read -p "Enter your option? [1, 2, 3, 4, 5, 6 or 7]: " useroption
if [ $useroption == '1' ]; then
   $OCI_VM_K8S/common/oci_config_setup.sh
elif [ $useroption == '2' ]; then
   $OCI_VM_K8S/common/oci_config_setup.sh
elif [ $useroption == '3' ]; then
   $OCI_VM_K8S/common/kube_setup.sh
elif [ $useroption == '4' ]; then
   $OCI_VM_K8S/domain-on-pv/custom/trigger.sh
 elif [ $useroption == '5' ]; then
   option_mig_to_k8s
elif [ $useroption == '6' ]; then
   option_main
elif [ $useroption == '7' ]; then
   exit
else
echo ""
   echo "Wrong input, Please enter a valid response..........";
   sleep 1
   option_k8s_7_wls_custom_on_pv
fi
echo ""
}



option_main
