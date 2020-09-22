#./oci_details.sh

echo "Install oci cli on bastion"
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"



echo "Copy to the oci console under Identity >> Users >> User Details"
echo "Add Public Key"
echo ""
read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    if [ $DOMAIN_TYPE == 'vanila' ]; then
    $SCRIPT_HOME/wls-migrate.sh option_k8s_4_wls_vanila
    elif [ $DOMAIN_TYPE == 'custom' ]; then
    $SCRIPT_HOME/wls-migrate.sh option_k8s_5_wls_custom
    fi
fi
