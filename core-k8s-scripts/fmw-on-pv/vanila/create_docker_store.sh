export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains
export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
source $OCI_VM_K8S/env.sh
export NS_NAME=$1
echo " "
echo " "
echo "Create docker store for pulling image from container.registry"
echo "========================================="
echo " "
echo " "
cd $PV_K8S_SAMPLE
#read -p "Enter Username: " username
#echo ""
#read -p "Enter Password: " password
#echo ""
#read -p "Enter email Id: " email

echo ""
echo ""
echo ""
echo "Input >>>"
echo "kubectl delete secret docker-store -n $NS_NAME-ns"
echo ""
echo ""
echo "Output <<<"
kubectl delete secret docker-store -n $NS_NAME-ns
echo ""
echo ""
echo ""
echo "Input >>>"
echo "kubectl -n soa-domain1-ns create secret docker-registry docker-store --docker-server=container-registry.oracle.com --docker-username=$ORCL_CONTAINER_USERNAME --docker-password=xxxxxxxx --docker-email=$ORCL_CONTAINER_EMAIL"
echo ""
echo ""
echo "Output <<<"
kubectl -n soa-domain1-ns create secret docker-registry docker-store --docker-server=container-registry.oracle.com --docker-username=$ORCL_CONTAINER_USERNAME --docker-password=$ORCL_CONTAINER_PASSWORD --docker-email=$ORCL_CONTAINER_EMAIL
echo ""
echo ""
echo ""
echo "docker-store created successfully in $NS_NAME-ns namespaces"
sleep 5

