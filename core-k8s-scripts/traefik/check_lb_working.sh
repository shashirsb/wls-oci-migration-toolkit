echo "Check if the laodblancer is working"
LB_IP=`kubectl describe svc traefik-operator --namespace traefik | grep Ingress | awk '{print $3}'`
echo "curl -H host: traefik.example.com http://$LB_IP"
curl -H 'host: traefik.example.com' http://$LB_IP
read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    continue;
else
   exit;
fi
echo " "
echo " "
