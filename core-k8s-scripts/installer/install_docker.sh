cd /etc/yum.repos.d/
sudo wget http://yum.oracle.com/public-yum-ol7.repo

echo "
[ol7_latest]
name=Oracle Linux $releasever Latest ($basearch)
baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/latest/$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1

[ol7_UEKR4]
name=Latest Unbreakable Enterprise Kernel Release 4 for Oracle Linux $releasever ($basearch)
baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/UEKR4/$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1

[ol7_addons]
name=Oracle Linux $releasever Add ons ($basearch)
baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/addons/$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1"

read -p "copy paste the above content in next file, make changes if needed: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    continue;
else
   exit;
fi

sudo vi public-yum-ol7.repo
sudo yum install docker-engine
sudo systemctl start docker
sudo chmod 777 /var/run/docker.sock
docker login

echo ""
read -p "If you want to continue press Y [Y/N]: " useroption
    $SCRIPT_HOME/wls-migrate.sh option_k8s_3_install_software
