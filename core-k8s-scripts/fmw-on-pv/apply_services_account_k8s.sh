export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
source $OCI_VM_K8S/env.sh
export NS_NAME=$1
clear
$SCRIPT_HOME/header.sh
echo ""
echo ""
echo ""
echo "Step 1 - Cloned > Step 2 - Creating"
echo "Git K8s Opr       Service Account  "

echo " "
echo " "
echo " Setting service account the necessary permissions: "
echo "=========================================="

echo ""
echo ""
echo "apiVersion: rbac.authorization.k8s.io/v1"
echo "kind: ClusterRoleBinding"
echo "metadata:"
echo "       name: helm-user-cluster-admin-role"
echo "subjects:"
echo "-       kind: ServiceAccount"
echo "        name: default"
echo "        namespace: kube-system"
echo "roleRef:"
echo "        kind: ClusterRole"
echo "        name: cluster-admin"
echo "        apiGroup: rbac.authorization.k8s.io"
echo " "
echo " "
echo "Copy paste the above and make changes and save in the next step.."
echo " "
echo " "
read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    continue;
else
   exit;
fi
cp $OCI_VM_K8S/access.permission.yaml $K8S_DOMAIN_HOME/$NS_NAME/access.permission.yaml
vi $K8S_DOMAIN_HOME/$NS_NAME/access.permission.yaml

#kubectl create -f access.permission.yaml
clear
$SCRIPT_HOME/header.sh
echo ""
echo ""
echo "Step 1 - Cloned > Step 2 - Creating"
echo "Git K8s Opr       Service Account  "
echo " "
echo " Lets apply the access permission to the k8s cluster"
echo "kubectl apply -f $K8S_DOMAIN_HOME/$NS_NAME/access.permission.yaml"
kubectl apply -f $K8S_DOMAIN_HOME/$NS_NAME/access.permission.yaml
echo " "
echo " "
echo "Successfully applied Access permission"
echo "======================================="
echo ""
sleep 2
