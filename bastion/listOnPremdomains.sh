#!/bin/bash
clear
SCRIPT_HOME=$HOME/wls-oci-migration-toolkit
echo ""
echo "==========================="
echo "On Prem Domain List:"
echo "==========================="
echo ""
ls -l $SCRIPT_HOME/bastion/output | grep ^d | awk '{print $9 "  created on " $6 " " $7 " " $8  }'
echo ""
echo ""
echo "==========================="
#ls -r $SCRIPT_HOME/bastion/output/*
echo ""
echo ""
read -p "If you want to continue press Y [Y/N]: " useroption
   $SCRIPT_HOME/wls-migrate.sh option_k8s_1_onprem_pack

