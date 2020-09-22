#!/bin/bash
cd $OCI_VM_K8S
echo " "
echo " "
echo "Install python3.6.3"
echo "==================="
echo " "
echo " "
sudo yum -y groupinstall development
sudo yum -y install zlib-devel
wget https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tar.xz
tar xJf Python-3.6.3.tar.xz
cd Python-3.6.3
./configure
make
sudo make install
#echo "alias python=python3" >> $HOME/.bashrc
source $HOME/.bashrc
python --version
echo " "
echo " "
echo " successfully install python3"
echo " "
echo " "
echo ""
echo ""
read -p "If you want to continue press Y [Y/N]: " useroption
   $SCRIPT_HOME/wls-migrate.sh option_k8s_3_install_software
