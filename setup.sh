#!/bin/bash
echo "alias migtool='cd $HOME/wls-oci-migration-toolkit;./wls-migrate.sh'" >> ~/.bashrc

read -p "Enter fullpath of  weblogic-deploy.zip. e.g., /home/opc/weblogic-deploy.zip : " wdtzip

read -p "Enter fullpath of jdk  e.g., /home/opc/jdk-8u261-linux-i586.tar.gz : " jdkzip

rm -rf $HOME/wls-oci-migration-toolkit/bastion/jdk $HOME/wls-oci-migration-toolkit/bastion/weblogic-deploy  $HOME/wls-oci-migration-toolkit/bastion/bastion.zip

mkdir -p $HOME/wls-oci-migration-toolkit/bastion/jdk
tar -xvf $jdkzip --directory $HOME/wls-oci-migration-toolkit/bastion/jdk
mv $HOME/wls-oci-migration-toolkit/bastion/jdk/*/* $HOME/wls-oci-migration-toolkit/bastion/jdk/

#unzip $jdkzip -d $HOME/wls-oci-migration-toolkit/bastion
#JDK_VERSION=`basename -s .zip $jdkzip`
#mv $HOME/wls-oci-migration-toolkit/bastion/$JDK_VERSION $HOME/wls-oci-migration-toolkit/bastion/jdk

unzip $wdtzip -d $HOME/wls-oci-migration-toolkit/bastion

cd $HOME/wls-oci-migration-toolkit
zip -r $HOME/wls-oci-migration-toolkit/bastion.zip bastion/

mv $HOME/wls-oci-migration-toolkit/bastion.zip $HOME/wls-oci-migration-toolkit/bastion/
rm -rf $HOME/wls-oci-migration-toolkit/bastion/bastion

clear;

echo "Migration tool is now ready !!!"
echo ""

