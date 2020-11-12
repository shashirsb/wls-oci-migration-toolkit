echo "Install Helm:"
echo "============="
echo " "
echo " "
wget https://get.helm.sh/helm-v3.1.0-linux-amd64.tar.gz
tar -zxvf helm-v3.1.0-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
echo ""
echo ""
echo "Successfully installed Helm"
echo "==========================="
echo ""
read -p "If you want to continue press Y [Y/N]: " useroption
    $SCRIPT_HOME/wls-migrate.sh option_k8s_3_install_software
