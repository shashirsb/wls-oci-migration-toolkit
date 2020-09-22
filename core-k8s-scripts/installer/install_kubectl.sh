cd $OCI_VM_K8S
echo " "
echo " "
echo "Install kubectl on bastion server:"
echo "=================================="

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
echo ""
echo ""
echo "Kubectl Version Details:"
echo "========================"
echo ""
kubectl version --client
echo " "
echo " "
read -p "If you want to continue press Y [Y/N]: " useroption
   $SCRIPT_HOME/wls-migrate.sh option_k8s_3_install_software 
