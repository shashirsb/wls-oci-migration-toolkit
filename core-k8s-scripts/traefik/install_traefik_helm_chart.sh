#!/bin/bash
clear
$SCRIPT_HOME/header.sh
export NS_NAME=$1
echo ""
echo ""
echo ""
echo "Step 1 - Cloned > Step 2 - Created >  Step 3 - Installed > Step 4 - Installed > Step 5 - Installing"
echo "Git K8s Opr       Service Account     k8s Opr (via helm)   Weblogic domain      traefik (via helm)"
echo ""
echo "Installing and configuring Traefik with a Helm chart:"
echo "====================================================="
echo " "
echo " "
echo "Input >>>"
echo "Create namespace traefik"
echo ""
echo "<<< Output"
echo "kubectl create namespace traefik"
kubectl create namespace traefik
echo " "
echo " "
echo "Input >>>"
echo "Create serviceaccount for traefik"
echo ""
echo "<<< Output"
echo "kubectl create serviceaccount -n traefik $NS_NAME-traefik-operator-sa"
kubectl create serviceaccount -n traefik $NS_NAME-traefik-operator-sa
echo " "
echo " "
echo "Input >>>"
echo "Install traefik operator"
echo ""
echo "<<< Output"
cd $HOME/weblogic-kubernetes-operator
#vi kubernetes/samples/charts/traefik/values.yaml
echo "helm install traefik-operator stable/traefik --namespace traefik --values kubernetes/samples/charts/traefik/values.yaml  --set "serviceAccount=$NS_NAME-traefik-operator-sa" --set "kubernetes.namespaces={traefik}" --set "serviceType=LoadBalancer"  --wait"
helm install traefik-operator stable/traefik --namespace traefik --values kubernetes/samples/charts/traefik/values.yaml  --set "serviceAccount=$NS_NAME-traefik-operator-sa" --set "kubernetes.namespaces={traefik}" --set "serviceType=LoadBalancer"  --wait
echo ""
echo ""
echo "Input >>>"
echo "Helm upgrade traefik"
echo ""
echo "<<< Output"
echo "helm upgrade --reuse-values --set "kubernetes.namespaces={traefik,$NS_NAME-ns}" --wait traefik-operator stable/traefik -n traefik"
helm upgrade --reuse-values --set "kubernetes.namespaces={traefik,$NS_NAME-ns}" --wait traefik-operator stable/traefik -n traefik
echo " "
echo " "
echo "List services for namespaces"
echo "kubectl get services --all-namespaces"
kubectl get services --all-namespaces
echo " "
echo " "
echo "Get the loadbalancer IP address"
echo "kubectl describe svc traefik-operator --namespace traefik | grep Ingress | awk '{print $3}'"
kubectl describe svc traefik-operator --namespace traefik | grep Ingress | awk '{print $3}'
echo " "
echo " "
echo "helm ls --all-namespaces"
helm ls --all-namespaces
echo " "
echo " "
echo "Successfully installed stable/traefik "
echo "==========================================================="
echo ""
echo ""
sleep 6
