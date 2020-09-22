#./oci_details.sh -x

echo " "
echo " "
echo "Create config file for kube:"
echo "============================"
echo " "
echo " "
echo "On Bastion Server:"
rm -rf $HOME/.kube
mkdir -p $HOME/.kube

echo " "
echo " "
read -p "Enter the k8s cluster id : " useroption
read -p "Enter the k8s region : " userregion
echo "oci ce cluster create-kubeconfig --cluster-id $useroption --file $HOME/.kube/config --region $userregion --token-version 2.0.0"
oci ce cluster create-kubeconfig --cluster-id $useroption --file $HOME/.kube/config --region $userregion --token-version 2.0.0 
echo " "
echo " "

echo "Creating the config file"
export KUBECONFIG=$HOME/.kube/config
ls -ltr $HOME/.kube/config
cat $HOME/.kube/config
echo " "
echo " "
echo "Configuration file created successfully"
echo ""
echo ""
echo "Find nodes:"
echo "==========="
kubectl get nodes
echo " "
echo " "
echo "Setting Access Control on OKE Cluster:"
echo "======================================"
read -p "Enter the ocid of user : " userregionocid
echo "kubectl create clusterrolebinding my-cluster-admin-binding --clusterrole=cluster-admin --user=ocid1.user.oc1..aaaaaaaadm5bgksiguoedcgp7zszuukweh647exriceuub4d3x4tpe7phbza" 
kubectl create clusterrolebinding my-cluster-admin-binding --clusterrole=cluster-admin --user=$userregionocid

echo "COMPLETED K8S CLUSTER, OCI CLI, CONFIGURATION SETUP AND Access"
echo "=============================================================="

read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    if [ $DOMAIN_TYPE == 'vanila' ]; then
    $SCRIPT_HOME/wls-migrate.sh option_k8s_4_wls_vanila
    elif [ $DOMAIN_TYPE == 'custom' ]; then
    $SCRIPT_HOME/wls-migrate.sh option_k8s_5_wls_custom
    fi
fi
