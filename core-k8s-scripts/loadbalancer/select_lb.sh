#!/bin/sh
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
export BASTION_HOME=$SCRIPT_HOME/bastion
export K8S_DOMAIN_HOME=$SCRIPT_HOME/bastion/output
export NS_NAME=$1
source $SCRIPT_HOME/core-k8s-scripts/domain-on-pv/env.sh

option_main (){
echo ""
echo " Please select one of the below option"
echo ""
echo " 1. LB within private netowrk "
echo " 2. LB access from public intenet "
echo ""
echo ""
read -p "Enter your option? [1 or 2]: " useroption
if [ $useroption == '1' ]; then
   echo " Finding IP address of the NodePort"
   echo " it may take few more moments for the services to come up, please wait...."
        wait_period=0
   	printf "["
	while true
do
    # Here 300 is 300 seconds i.e. 5 minutes * 60 = 300 sec
    wait_period=$(($wait_period+1))
    if [ $wait_period -gt 1 ];then
       break
    else
	   printf  "â"
       sleep 1
    fi
done

printf "] done!"
echo ""
export LB_IP=`kubectl describe svc $NS_NAME-admin-server-external -n $NS_NAME-ns | grep IP  | awk '{print $2}'`
echo "Admin console URL:"
echo "http://$LB_IP:7001/console"
sleep 10
elif [ $useroption == '2' ]; then
  	$TRAEFIK_HOME/install_traefik_helm_chart.sh $NS_NAME
	$TRAEFIK_HOME/check_lb_working.sh $NS_NAME
	$TRAEFIK_HOME/apply_traefik_sample.sh $NS_NAME
        export LB_IP=`kubectl describe svc traefik-operator --namespace traefik | grep Ingress | awk '{print $3}'`
        echo "Admin console URL:"
	echo "http://$LB_IP:7001/console"
	sleep 10
else
   echo ""
   echo "Wrong input, Please enter a valid response..........";
   sleep 1
   option_main
fi
echo ""
echo ""
}

option_main
