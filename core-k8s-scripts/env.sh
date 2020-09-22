#!/bin/bash


# WEBLOGIC KUBERNETES OPERATOR
export WLS_KUBE_OPTR=3.0.1


# ORACLE CONTAINER REGISTRY LOGIN DETAILS https://container-registry.oracle.com/
ORCL_CONTAINER_USERNAME=shashi@test.com
ORCL_CONTAINER_PASSWORD=R5XXXXXXXXX
ORCL_CONTAINER_EMAIL=shashi@test.com

# DOCKER HUB LOGIN DETAILS https://hub.docker.com/
DOCKERHUB_USERNAME=shashioracle
DOCKERHUB_PASSWORD=R5XXXXXXXX












############################### DO NOT MODIFY #######################################

export SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
export DOMAIN_CONFIG=$SCRIPT_HOME/domains

export OCI_VM_SCRIPT=$SCRIPT_HOME/core-oci-scripts
export OCI_VM_K8S=$SCRIPT_HOME/core-k8s-scripts
export BASTION_HOME=$SCRIPT_HOME/bastion
export K8S_DOMAIN_HOME=$SCRIPT_HOME/bastion/output
export TRAEFIK_HOME=$SCRIPT_HOME/core-k8s-scripts/traefik
export LB_HOME=$SCRIPT_HOME/core-k8s-scripts/loadbalancer

#PV OPERATOR SAMPLE HOME
export PV_K8S_SAMPLE=$HOME/weblogic-kubernetes-operator/kubernetes/samples/scripts/create-weblogic-domain-pv-pvc

# SOA SAMPLE ON PV
export PV_K8S_SOA_SAMPLE=$HOME/weblogic-kubernetes-operator/kubernetes/samples/scripts/create-soa-domain/domain-home-on-pv

# RCU SAMPLE
export RCU_CREDENTIALS_SAMPLE=$HOME/weblogic-kubernetes-operator/kubernetes/samples/scripts/create-rcu-credentials
export RCU_SCHEMA_SAMPLE=$HOME/weblogic-kubernetes-operator/kubernetes/samples/scripts/create-rcu-schema

# DATBASE SAMPLE
export DB_SAMPLE=$HOME/weblogic-kubernetes-operator/kubernetes/samples/scripts/create-oracle-db-service

# DOMAIN IN IMAGE
export DOMAIN_IN_IMAGE_K8S_SAMPLE=$HOME/weblogic-kubernetes-operator/kubernetes/samples/scripts/create-weblogic-domain/domain-home-in-image
export DOMAIN_IN_IMAGE_HOME=$SCRIPT_HOME/core-k8s-scripts/domain-in-image
export DOMAIN_IN_IMAGE_HOME_CUSTOM=$SCRIPT_HOME/core-k8s-scripts/domain-in-image/custom
export DOMAIN_IN_IMAGE_HOME_VANILA=$SCRIPT_HOME/core-k8s-scripts/domain-in-image/vanila

#DOMAIN ON PV
export DOMAIN_ON_PV_K8S_SAMPLE=$HOME/weblogic-kubernetes-operator/kubernetes/samples/scripts/create-weblogic-domain/domain-home-on-pv
export DOMAIN_ON_PV_HOME=$SCRIPT_HOME/core-k8s-scripts/domain-on-pv
export DOMAIN_ON_PV_HOME_CUSTOM=$SCRIPT_HOME/core-k8s-scripts/domain-on-pv/custom
export DOMAIN_ON_PV_HOME_VANILA=$SCRIPT_HOME/core-k8s-scripts/domain-on-pv/vanila

#FMW ON PV
export FMW_ON_PV_HOME=$SCRIPT_HOME/core-k8s-scripts/fmw-on-pv
export FMW_ON_PV_HOME_CUSTOM=$SCRIPT_HOME/core-k8s-scripts/fmw-on-pv/custom
export FMW_ON_PV_HOME_VANILA=$SCRIPT_HOME/core-k8s-scripts/fmw-on-pv/vanila

#CREATE DOCKER IMAGE
export CREATE_DOCKER_IMAGE_HOME=$SCRIPT_HOME/core-k8s-scripts/create-docker-image
export CREATE_DOCKER_IMAGE_HOME_CUSTOM=$SCRIPT_HOME/core-k8s-scripts/create-docker-image/custom

