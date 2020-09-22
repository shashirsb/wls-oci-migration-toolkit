#!/bin/bash
export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
export BASTION_HOME=$SCRIPT_HOME/bastion
export K8S_DOMAIN_HOME=$SCRIPT_HOME/bastion/output
export TRAEFIK_HOME=$SCRIPT_HOME/core-k8s-scripts/traefik
export LB_HOME=$SCRIPT_HOME/core-k8s-scripts/loadbalancer
export PV_K8S_SAMPLE=$HOME/weblogic-kubernetes-operator/kubernetes/samples/scripts/create-weblogic-domain-pv-pvc
export DOMAIN_ON_PV_K8S_SAMPLE=$HOME/weblogic-kubernetes-operator/kubernetes/samples/scripts/create-weblogic-domain/domain-home-on-pv
export DOMAIN_ON_PV_HOME=$SCRIPT_HOME/core-k8s-scripts/domain-on-pv
export DOMAIN_ON_PV_HOME_CUSTOM=$SCRIPT_HOME/core-k8s-scripts/domain-on-pv/custom
export DOMAIN_ON_PV_HOME_VANILA=$SCRIPT_HOME/core-k8s-scripts/domain-on-pv/vanila
ORCL_CONTAINER_USERNAME=shashi.rsb@hotmail.com
ORCL_CONTAINER_PASSWORD=R5sb9090@@@@@
ORCL_CONTAINER_EMAIL=shashi.rsb@hotmail.com
