#!/bin/bash
/usr/bin/docker images|grep -v '<none>'

read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    $SCRIPT_HOME/wls-migrate.sh option_mig_to_k8s
fi
option_mig_to_k8s
