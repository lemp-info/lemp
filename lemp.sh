#!/bin/bash
jeshile='\e[40;38;5;82m' 
jo='\e[0m'  
red='\e[31m'
yellow='\e[0;93m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo " "
echo -e "${yellow} ???????????????????????????????????????????????? \e[0m"
echo -e "${yellow} ?               www.lemp.info                  ? \e[0m"
echo -e "${yellow} ?              Lemp installer                  ? \e[0m"
echo -e "${yellow} ???????????????????????????????????????????????? \e[0m"
echo " " 
sleep 5

echo " "
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo -e "${jeshile} ?               Update System                  ? \e[0m"
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo " " 
sudo apt update
sudo apt install -y lsb-core 

yum -y update
yum install redhat-lsb-core -y

osname=$(lsb_release -si)
osrelease=$(lsb_release -sr)
arch=$(uname -m)
openssl=$(openssl version)
file=/etc/rc.local
file2=$(cat /etc/rc.local | grep -c "/etc/rc.d/rc0.d/lemp start")

echo " "
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo -e "${jeshile} ?            Checking System Version           ? \e[0m"
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo " " 

if [ "$osname" == "Ubuntu"  ] || [ "$osname" == "CentOS"  ]; then
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo -e "${jeshile} ?             Support System                   ? \e[0m"
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
else
echo -e "${red} ???????????????????????????????????????????????? \e[0m"
echo -e "${red} ?[+]        The system is not supported        ? \e[0m"
echo -e "${red} ???????????????????????????????????????????????? \e[0m"
exit 3  
fi 
if [[ $osrelease  = "6."* ]] ; then 
echo -e "${red} ???????????????????????????????????????????????? \e[0m"
echo -e "${red} ?[+]        The system is not supported        ? \e[0m"
echo -e "${red} ???????????????????????????????????????????????? \e[0m"
exit 3
fi
if [ "$arch" = "x86_64" ] ; then
echo " "
else
echo -e "${red} ???????????????????????????????????????????????? \e[0m"
echo -e "${red} ?[+]        The system is not supported        ? \e[0m"
echo -e "${red} ???????????????????????????????????????????????? \e[0m"
exit 3  
fi 

echo " "
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo -e "${jeshile} ?         NEW password for your MySQL          ? \e[0m"
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo " " 

read -p "Do you want to install MariaDB ? [y/n]: " MariaDB
if [ $MariaDB = "y" ];then
while true; do
    echo 
 read -s -p "New password for the MySQL "root" user: " SQL
  echo 
 read -s -p "Repeat password for the MySQL "root" user: " SQL2
 echo " "
    [ "$SQL" = "$SQL2" ] && break
echo -e "${red}Please try again${NC}"
done
fi
			
echo " "
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo -e "${jeshile} ?            Install Lemp  Server              ? \e[0m"
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo " " 

groupadd mysql
useradd -r -g mysql mysql
/usr/sbin/useradd -s /sbin/nologin -U -d /home/lemp -m lemp

if [ "$osname" == "Ubuntu"  ] ; then 
apt-get -y update
apt-get remove -y apache2 
apt-get install -y --force-yes lsb-release nscd curl 
apt-get install -y --force-yes libxslt1-dev  
apt-get install -y --force-yes libpq-dev 
apt-get install -y --force-yes libmcrypt-dev 
apt-get install -y --force-yes libltdl7 
apt-get install -y --force-yes libssh2-1-dev 
apt-get install -y --force-yes libgeoip-dev  
apt-get install -y --force-yes libjpeg8 
apt-get install -y --force-yes cron 
apt-get install -y --force-yes libcurl4-openssl-dev 
apt-get install -y --force-yes libpq5 
apt-get install -y --force-yes dist-upgrade 
apt-get install -y --force-yes cron 
apt-get install -y --force-yes libpng12-0 
apt-get install -y --force-yes libjpeg8 
apt-get install -y --force-yes libcurl3 
apt-get install -y --force-yes iftop 
apt-get install -y --force-yes libgconf-2-4 
apt-get install -y --force-yes libcurl3-gnutls
apt-get install -y --force-yes alien elfutils 
apt-get install -y --force-yes numactl
apt-get install -y --force-yes install libaio
apt-get install -y --force-yes libaio1 
apt-get install -y --force-yes libaio-dev
apt-get install -y --force-yes openssl
if [ "$osrelease" == "16.04"  ] ; then 
sudo apt-get install -y --force-yes libfile-copy-recursive-perl
sleep 1
sudo apt-get install -y --force-yes sysstat  
fi

#if [ "$osrelease" == "14.04" ] ; then
#apt-get remove -y openssl 
#sleep 1
#apt-get install -y --force-yes openssl
#fi

if [ "$osrelease" = "18.04" ] || [ "$osrelease" = "19.04" ]; then
sudo apt-get install -y --force-yes libfile-copy-recursive-perl
sudo apt-get install -y --force-yes sysstat 
wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb && dpkg -i /tmp/libpng12.deb   && rm /tmp/libpng12.deb   
fi

sleep 1
if [ "$osrelease" == "19.04" ] ; then 
sudo apt-get install -y --force-yes libncurses5
sudo apt-get remove -y libcurl4  
wget http://download-ib01.fedoraproject.org/pub/fedora/linux/releases/29/Everything/x86_64/os/Packages/l/libpng12-1.2.57-8.fc29.x86_64.rpm -P /root    
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb -P /root  
wget http://archive.ubuntu.com/ubuntu/pool/universe/c/curl3/libcurl3_7.58.0-2ubuntu2_amd64.deb -P /root  
sudo alien -cv *.rpm
sudo dpkg -i *.deb
rm -r *.deb 
rm -r *.rpm 
sudo ln -s /usr/lib64/libpng12.so.0 /usr/lib/x86_64-linux-gnu/libpng12.so.0
fi

wget https://sourceforge.net/projects/lemp-info/files/lempNEW.tar.gz -P /home/lemp/ 
tar -xvzf  /home/lemp/lempNEW.tar.gz -C /home/lemp
rm -r /home/lemp/lempNEW.tar.gz

if [ $MariaDB != "y" ]; then
rm -rf /home/lemp/script/lemp
mv /home/lemp/script/lemp2 /home/lemp/script/lemp
rm -r /home/lemp/script/mysql.server
rm -r /home/lemp/script/my.cnf
else
rm -rf /home/lemp/script/lemp2
fi

sudo chmod -R 755 /home/lemp/script/*
mv /home/lemp/script/* /etc/init.d/
sudo dpkg -i  /home/lemp/libicu52_52.1-3ubuntu0.4_amd64.deb
rm -r /home/lemp/*.deb
fi

if [[ $openssl != *"1.1.1"* ]]; then
#wget https://www.openssl.org/source/openssl-1.1.1c.tar.gz  -P /home/lemp/ 
tar zxvf /home/lemp/openssl-1.1.1c.tar.gz -C /home/lemp
cd /home/lemp/openssl-1.1.1c/
./config
make install
cp libcrypto.so.1.1 /usr/lib/x86_64-linux-gnu/
cp libssl.so.1.1 /usr/lib/x86_64-linux-gnu/
rm /usr/bin/openssl
ln -s /usr/local/bin/openssl /usr/bin/openssl
rm -r /home/lemp/openssl-1.1.1c.tar.gz
rm -r /home/lemp/openssl-1.1.1c
fi

if [ "$osname" == "CentOS" ]; then
yum remove  -y httpd
yum istall  -y wget
yum install -y libxml2 libxml2-devel 
yum install -y openssl openssl-devel
yum install -y bzip2 bzip2-devel 
yum install -y libcurl libcurl-devel
yum install -y libjpeg libjpeg-devel
yum install -y libpng libpng-devel
yum install -y freetype freetype-devel
yum install -y gmp gmp-devel 
yum install -y libmcrypt ibmcrypt-devel 
yum install -y readline readline-devel 
yum install -y libxslt libxslt-devel 
yum install -y libaio-devel.x86_64 
yum install -y libncurses* 
yum install -y sqlite-devel.x86_64 
yum install -y systemd-devel 
#yum install -y iptables-services
if [[ $osrelease  = "7."* ]] ; then 
yum install https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/o/oniguruma-5.9.5-3.el7.x86_64.rpm -y
yum install https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/o/oniguruma-devel-5.9.5-3.el7.x86_64.rpm -y
fi
if [[ $osrelease  = "8."* ]] ; then 
yum install http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/oniguruma-6.8.2-1.el8.x86_64.rpm -y
fi

wget https://sourceforge.net/projects/lemp-info/files/lempCentOS.tar.gz -P /home/lemp/ 
tar -xvzf  /home/lemp/lempCentOS.tar.gz -C /home/lemp
rm -rf /home/lemp/lempCentOS.tar.gz
if [ $MariaDB != "y" ];then
rm -rf /home/lemp/script/mysql.server
fi
sudo chmod -R 755 /home/lemp/script/*
cp /home/lemp/script/mysql.server /etc/rc.d/init.d/
mv /home/lemp/script/* /etc/rc.d/rc0.d/  

if [[ $osrelease  = "8."* ]] ; then 
rm -rf /home/lemp/php
wget  https://sourceforge.net/projects/lemp-info/files/lempCentOS8PHP741.gz -P /home/lemp/ 
sudo chmod -R 755 /home/lemp/lempCentOS8PHP741.tar.gz
tar -xvzf /home/lemp/lempCentOS8PHP741.gz -C /home/lemp/
rm -rf /home/lemp/lempCentOS8PHP741.gz
fi
fi

mv /home/lemp/phpmyadmin/phpmyadmin.sql /home/lemp/
mv /home/lemp/phpmyadmin/config.inc.php /home/lemp/
rm -rf /home/lemp/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz  -P /home/lemp/ 
sudo chmod -R 755 /home/lemp/phpMyAdmin-4.9.4-all-languages.tar.gz
tar -xvzf /home/lemp/phpMyAdmin-4.9.4-all-languages.tar.gz -C /home/lemp/
rm -rf /home/lemp/phpMyAdmin-4.9.4-all-languages.tar.gz
mv /home/lemp/phpMyAdmin-4.9.4-all-languages /home/lemp/phpmyadmin
mv /home/lemp/phpmyadmin.sql /home/lemp/phpmyadmin/
mv /home/lemp/config.inc.php /home/lemp/phpmyadmin/
mkdir /home/lemp/phpmyadmin/tmp

if [ $MariaDB = "y" ];then
wget http://mirrors.up.pt/pub/mariadb//mariadb-10.5.0/bintar-linux-systemd-x86_64/mariadb-10.5.0-linux-systemd-x86_64.tar.gz -P /home/lemp/ 
sudo tar -xvf /home/lemp/mariadb-10.5.0-linux-systemd-x86_64.tar.gz -C /home/lemp 
sudo mv  /home/lemp/mariadb-10.5.0-linux-systemd-x86_64 /home/lemp/mysql
rm -rf /home/lemp/mariadb-10.5.0-linux-systemd-x86_64.tar.gz
rm -rf /home/lemp/mysql/support-files/mysql.server
sudo chmod -R 755 /etc/init.d/mysql.server
cp /etc/init.d/mysql.server /home/lemp/mysql/support-files/
sudo chmod -R 755 /home/lemp
sudo chmod -R 755 /home/lemp/mysql
sleep 1
export PATH=/home/lemp/mysql/bin:$PATH
sleep 1
chown -R mysql.mysql /home/lemp/mysql
rm -rf /home/lemp/mysql/data
sleep 1
sudo /home/lemp/mysql/scripts/mysql_install_db --user=mysql --basedir=/home/lemp/mysql/ --datadir=/home/lemp/mysql/data
echo -e " \n "
sleep 1
#sudo /home/lemp/mysql/bin/mysqld_safe --user=mysql --basedir=/home/lemp/mysql/ --datadir=/home/lemp/mysql/data &
echo -e " \n "
sleep 1
ln -s /home/lemp/mysql/bin/* /usr/local/bin/
sleep 1
mv /etc/my.cnf /etc/my.cnf-old
sleep 1
sudo chmod -R 755 /home/lemp/mysql/support-files/mysql.server
sleep 1
/home/lemp/mysql/support-files/mysql.server start
sleep 1
sudo /home/lemp/mysql/bin/mysqladmin -u root password "$SQL"
sleep 1
mysql -uroot -p"$SQL" -e "CREATE DATABASE phpmyadmin"  
mysql -uroot -p"$SQL" phpmyadmin < /home/lemp/phpmyadmin/phpmyadmin.sql 
fi

if [ "$osname" == "Ubuntu" ]; then
if [ -f "$file" ]
then
sed --in-place '/exit 0/d' /etc/rc.local 
echo "sleep 2" >> /etc/rc.local
echo "sudo /etc/init.d/lemp start" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
else 
echo "#!/bin/sh -e" >> /etc/rc.local
echo "#">> /etc/rc.local
echo "# rc.local">> /etc/rc.local
echo "#">> /etc/rc.local
echo "# This script is executed at the end of each multiuser runlevel." >> /etc/rc.local
echo "# value on error." >> /etc/rc.local
echo "#" >> /etc/rc.local
echo "# In order to enable or disable this script just change the execution" >> /etc/rc.local
echo "# bits." >> /etc/rc.local
echo "#" >> /etc/rc.local
echo "# By default this script does nothing." >> /etc/rc.local
echo -e " \n " >> /etc/rc.local
echo "sleep 2" >> /etc/rc.local
echo "sudo /etc/init.d/lemp start" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
sleep 1
chmod +x /etc/rc.local  
fi
rm -r /home/lemp/openssl-1.1.1c > /dev/null 2>&1
rm -r /home/lemp/openssl-1.1.1c.tar.gz > /dev/null 2>&1
sudo /etc/init.d/lemp start
fi

if [ "$osname" == "CentOS" ]; then
if [ $file2 -eq 1 ]; then
echo " "   
else
echo "/etc/rc.d/rc0.d/lemp start" >> /etc/rc.local
fi
chmod +x /etc/rc.local
sudo /etc/rc.d/rc0.d/lemp start
fi

sudo chmod 755 /home/lemp/phpmyadmin/tmp
sudo chmod 777 /home/lemp/phpmyadmin/tmp 

read -p "$(tput setaf 1)Reboot now (y/n)?$(tput sgr0) " CONT
if [ "$CONT" == "y" ] || [ "$CONT" == "Y" ]; then
reboot
fi
