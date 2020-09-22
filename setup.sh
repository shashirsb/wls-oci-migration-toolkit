#!/bin/bash -x
echo "alias migtool='cd $HOME/wls-oci-migration-toolkit;./wls-migrate.sh'" >> ~/.bashrc

read -p "Enter fullpath of  weblogic-deploy.zip. e.g., /home/opc/weblogic-deploy.zip : " wdtzip

read -p "Enter fullpath of jdkzip e.g., /home/opc/jdkzip : " jdkzip

unzip $jdkzip -d $HOME/wls-oci-migration-toolkit/bastion

JDK_VERSION=`basename -s .zip $jdkzip`
mv $HOME/wls-oci-migration-toolkit/bastion/$JDK_VERSION $HOME/wls-oci-migration-toolkit/bastion/jdk

unzip $wdtzip -d $HOME/wls-oci-migration-toolkit/bastion

cd $HOME/wls-oci-migration-toolkit
zip -r $HOME/wls-oci-migration-toolkit/bastion.zip bastion/

mv $HOME/wls-oci-migration-toolkit/bastion.zip $HOME/wls-oci-migration-toolkit/bastion/
rm -rf $HOME/wls-oci-migration-toolkit/bastion/bastion

