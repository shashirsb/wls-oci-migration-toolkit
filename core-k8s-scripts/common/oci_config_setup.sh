#./oci_details.sh


echo " "
echo " "
echo "Creating config on bastion server"
echo "Running setup config cmd"
oci setup config
cat $HOME/.oci/oci_api_key_public.pem

echo "Copy to the oci console under Identity >> Users >> User Details"
echo "Add Public Key"
echo ""
read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]: then
    if [ $DOMAIN_TYPE == 'vanila' ]; then
    $SCRIPT_HOME/wls-migrate.sh option_k8s_4_wls_vanila
    elif [ $DOMAIN_TYPE == 'custom' ]; then
    $SCRIPT_HOME/wls-migrate.sh option_k8s_5_wls_custom
    fi
fi
