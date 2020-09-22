export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
export BASTION_HOME=$SCRIPT_HOME/bastion
export K8S_DOMAIN_HOME=$SCRIPT_HOME/bastion/output
export NS_NAME=$1
echo " "
echo " "
echo "traefik ingress rule"
echo "===================="
echo " "
echo " "
echo "apiVersion: extensions/v1beta1"
echo "kind: Ingress"
echo "metadata:"
echo "  name: traefik-route-$NS_NAME-1"
echo "  namespace: $NS_NAME-ns"
echo "  annotations:"
echo "    kubernetes.io/ingress.class: traefik"
echo "spec:"
echo "  rules:"
echo "  - host:"
echo "    http:"
echo "      paths:"
echo "      - path: /"
echo "        backend:"
echo "          serviceName: $NS_NAME-cluster-cluster-1"
echo "          servicePort: 8001"
echo "      - path: /console"
echo "        backend:"
echo "          serviceName: $NS_NAME-admin-server"
echo "          servicePort: 7001"

read -p "Copy paste the above content in next file, make changes if needed:[Y/N " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    continue;
else
   exit;
fi
cp $OCI_VM_K8S/traefik-ingress-rule.yaml $K8S_DOMAIN_HOME/$NS_NAME/traefik-ingress-rule.yaml
sed -i 's/$NS_NAME/'$NS_NAME'/g' $K8S_DOMAIN_HOME/$NS_NAME/traefik-ingress-rule.yaml
vi $K8S_DOMAIN_HOME/$NS_NAME/traefik-ingress-rule.yaml
#kubectl create -f traefik-ingress-rule.yaml
#clear
echo ""
$SCRIPT_HOME/header.sh
echo ""
echo ""
echo "Step 1 - Cloned > Step 2 - Created >  Step 3 - Installed > Step 4 - Installed > Step 5 - Installing"
echo "Git K8s Opr       Service Account     k8s Opr (via helm)   Weblogic domain      traefik (via helm)"
echo " "
echo " "
echo "Input >>>"
echo "Apply traefik ingress rule to k8s cluster"
echo ""
echo "<<< Output"
echo "kubectl apply -f $K8S_DOMAIN_HOME/$NS_NAME/traefik-ingress-rule.yaml"
kubectl apply -f $K8S_DOMAIN_HOME/$NS_NAME/traefik-ingress-rule.yaml	
echo ""
echo ""
sleep 4
echo " "
echo ""
echo " "
echo "Step 1 - Cloned > Step 2 - Created >  Step 3 - Installed > Step 4 - Installed > Step 5 - Installed"
echo "Git K8s Opr       Service Account     k8s Opr (via helm)   Weblogic domain      traefik (via helm)"
echo ""
echo ""
echo "Installation is now Complete"
echo ""
echo "lets wait for the domain to come up"
sleep 5
