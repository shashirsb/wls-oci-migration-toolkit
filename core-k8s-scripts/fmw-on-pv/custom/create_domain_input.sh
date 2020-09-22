source $OCI_VM_K8S/domain-on-pv/env.sh
export NS_NAME=$1
echo " "
echo " "
echo "Create Domain on PV in  Kubernetes cluster"
echo "========================================="
echo " "
echo " "
cd $DOMAIN_ON_PV_K8S_SAMPLE
echo "Input >>>"
echo "./create-domain.sh  -i create-domain-inputs.yaml -o output"
echo ""
echo ""
echo "Output <<<"
./create-domain.sh  -i create-domain-inputs.yaml -o output
echo ""
echo ""
echo ""
cp -R $DOMAIN_ON_PV_K8S_SAMPLE/output $K8S_DOMAIN_HOME/$NS_NAME/
echo ""
sleep 5

