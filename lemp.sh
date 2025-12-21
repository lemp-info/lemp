#!/bin/bash
jeshile='\e[40;38;5;82m' 
jo='\e[0m'  
red='\e[31m'
yellow='\e[0;93m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo " "
whiptail --title "Lemp installer" --msgbox "                               https://github.com/lemp-info " 8 78
sleep 2

echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo -e "${jeshile} ?               Update System                  ? \e[0m"
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo " " 
sudo apt install -y update
sudo apt install -y lsb-core 
sudo apt install -y dialog 
sudo apt install -y whiptail

yum -y update
yum -y dialog
yum install redhat-lsb-core -y

osname=$(lsb_release -si)
osrelease=$(lsb_release -sr)
arch=$(uname -m)
openssl=$(openssl version)
file=/etc/rc.local
filelemp=/home/lemp
file2=$(cat /etc/rc.local | grep -c "/etc/rc.d/rc0.d/lemp start")
type mysql >/dev/null 2>&1 && mysqlstatus="y" || mysqlstatus="n"	 

echo " "
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo -e "${jeshile} ?            Checking System Version           ? \e[0m"
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo " " 

if [ "$osname" == "Ubuntu"  ] || [ "$osname" == "CentOS"  ]   ; then
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
#
if [ -d "$filelemp" ]; then
if (whiptail --title "database phpmyadmin." --yesno "Lemp already install ! Do you want to uninstall Lemp  ?" 8 78); then  
if (whiptail --title "database phpmyadmin." --yesno "Do you want to backup ' /home/lemp/www ' ?" 8 78); then   
backupwww="y"
else
backupwww="n"	 
fi 
uninstalllemp="y"
else
exit 1
fi 
fi
#
if [ $mysqlstatus = "y" ]  ; then

if whiptail   --title "Mysql already installed" --yesno "do you want to uninstall mysql ?" 8 78 --defaultno; then
if (whiptail --title "database phpmyadmin." --yesno "Do you want to database backup ?" 8 78); then   
backup="y"
else
backup="n"	 
fi 
if [ $backup = "y" ];then
while true; do
 echo 
mysqlpassword=$(whiptail --title "MariaDB Password" --passwordbox "Please enter your mysql password." 10 60 3>&1 1>&2 2>&3)
 echo 
RESULT=`mysqlshow --user=root --password=$mysqlpassword mysql | grep -v Wildcard | grep -o mysql `
[ "$RESULT" = "mysql" ] && break
done
sleep 1
mysqldump -uroot -p"$mysqlpassword" --all-databases > /root/all_databases.sql
sleep 1
fi 
sudo apt-get remove --purge mysql* -y
sleep 1
sudo apt-get purge mysql* -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo apt-get remove dbconfig-mysql -y
sudo apt-get dist-upgrade -y  
else
  echo " "
fi
fi
#
type mysql >/dev/null 2>&1 && mysqlstatus="y" || mysqlstatus="n"	 
echo " " 

if [ $mysqlstatus = "n" ]; then
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo -e "${jeshile} ?         NEW password for your MySQL          ? \e[0m"
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo " " 
if (whiptail --title "MariaDB" --yesno "Do you want to install MariaDB ?" 8 78); then   
MariaDB="y"	 
while true; do
    echo 
SQL=$(whiptail --title "MariaDB Password" --passwordbox "Enter your New password for the MariaDB " 10 60 3>&1 1>&2 2>&3)
  echo 
SQL2=$(whiptail --title "MariaDB Password" --passwordbox "Enter your Repeat password for the MariaDB " 10 60 3>&1 1>&2 2>&3)
 echo " "
    [ "$SQL" = "$SQL2" ] && break
done
sudo groupadd mysql
sudo useradd -r -g mysql mysql	
else
MariaDB="n" 		
fi 
else
MariaDB="n"
fi		
 
 


if [ "$osrelease" = "24.04" ]; then
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo -e "${jeshile} ?         NEW password for your MongoDB          ? \e[0m"
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo " " 
if (whiptail --title "mongoDB" --yesno "Do you want to install mongoDB ?" 8 78); then   
mongoDB="y"	 
while true; do
    echo 
PASSMONGO=$(whiptail --title "mongoDB Password" --passwordbox "Enter your New password for the mongoDB " 10 60 3>&1 1>&2 2>&3)
  echo 
PASSMONGO2=$(whiptail --title "mongoDB Password" --passwordbox "Enter your Repeat password for the mongoDB " 10 60 3>&1 1>&2 2>&3)
 echo " "
    [ "$PASSMONGO" = "$PASSMONGO2" ] && break
done
 
else
mongoDB="n" 		
fi 
else
mongoDB="n"
fi		
 




 
echo " "
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo -e "${jeshile} ?            Install Lemp  Server              ? \e[0m"
echo -e "${jeshile} ???????????????????????????????????????????????? \e[0m"
echo " " 
sudo /usr/sbin/useradd -s /sbin/nologin -U -d /home/lemp -m lemp


if [ "$osname" == "Ubuntu"  ]  ; then 
 if [ "$osrelease" == "18.04" ] || [ "$osrelease" == "19.04" ] || [ "$osrelease" == "20.04" ] || [ "$osrelease" == "15" ]  ; then
 
PHPV=$(whiptail --title " PHP Version"  --menu "What PHP Version do you want to install ?" 15 60 4  \
"1" "PHP 7.3.16" \
"2" "PHP 7.4.16 " \
"3" "PHP 8.0.3"   3>&1 1>&2 2>&3)
  fi
   fi
  
  
if [ "$osname" == "Ubuntu"  ] ; then 
 
sudo apt-get -y  clean
sudo apt-get install  -y  -f
sudo dpkg --configure -a
apt-get -y update
apt-get remove -y apache2 
apt-get install -y --force-yes lsb-release nscd curl 
apt-get install -y --force-yes libxslt1-dev  
apt-get install -y --force-yes libpq-dev 
apt-get install -y --force-yes libmcrypt-dev 
apt-get install -y --force-yes libltdl7 
apt-get install -y --force-yes libssh2-1-dev 
apt-get install -y --force-yes libssh2-1
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
apt-get install -y --force-yes libevent-dev
apt-get install -y --force-yes openssl libssl-dev make
apt-get install -y --force-yes curl
if [ "$osrelease" == "16.04"  ] ; then 
sudo apt-get install -y --force-yes libfile-copy-recursive-perl
sleep 1
sudo apt-get install -y --force-yes sysstat  
wget -q -O /tmp/libicu60_60.2-3ubuntu3_amd64.deb https://github.com/lemp-info/lemp/raw/master/libicu60_60.2-3ubuntu3_amd64.deb && dpkg -i /tmp/libicu60_60.2-3ubuntu3_amd64.deb  && rm /tmp/libicu60_60.2-3ubuntu3_amd64.deb
wget -q -O /tmp/libonig4_6.7.0-1_amd64.deb https://github.com/lemp-info/lemp/raw/master/libonig4_6.7.0-1_amd64.deb && dpkg -i /tmp/libonig4_6.7.0-1_amd64.deb && rm /tmp/libonig4_6.7.0-1_amd64.deb
wget -q -O /tmp/libzip4_1.0.1-0ubuntu1_amd64.deb https://github.com/lemp-info/lemp/raw/master/libzip4_1.0.1-0ubuntu1_amd64.deb && dpkg -i /tmp/libzip4_1.0.1-0ubuntu1_amd64.deb  && rm /tmp/libzip4_1.0.1-0ubuntu1_amd64.deb
apt-get install -y --force-yes libcurl4-openssl-dev 
fi
sleep 2
if [ "$osrelease" = "18.04" ] || [ "$osrelease" = "19.04" ]; then
sudo apt-get install -y --force-yes libfile-copy-recursive-perl
sudo apt-get install -y --force-yes sysstat 
wget -q -O /tmp/libpng12.deb https://github.com/lemp-info/lemp/raw/master/libpng12-0_1.2.54-1ubuntu1_amd64.deb && dpkg -i /tmp/libpng12.deb   && rm /tmp/libpng12.deb  
apt-get install -y --force-yes libcurl4-openssl-dev 
fi
sleep 2
if [ "$osrelease" == "19.04" ] || [ "$osrelease" = "20.04" ] ; then 
sudo apt-get install -y --force-yes libncurses5
sudo apt-get remove -y libcurl4  
wget https://github.com/lemp-info/lemp/raw/master/libpng12-1.2.57-8.fc29.x86_64.rpm -P /root    
wget https://github.com/lemp-info/lemp/raw/master/libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb -P /root  
wget https://github.com/lemp-info/lemp/raw/master/libcurl3_7.58.0-2ubuntu2_amd64.deb -P /root  
sudo alien -cv *.rpm
sudo dpkg -i *.deb
rm -r *.deb 
rm -r *.rpm 
sudo ln -s /usr/lib64/libpng12.so.0 /usr/lib/x86_64-linux-gnu/libpng12.so.0
apt-get install -y --force-yes libcurl4-openssl-dev 
fi
sleep 1

if [ "$osrelease" == "19.04" ] || [ "$osrelease" = "20.04" || [ "$osrelease" = "16.04" ] || [ "$osrelease" = "18.04" ] ; then  
while true; do
#wget --load-cookies /tmp/cookies_lemp.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies_lemp.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=1dHIwBLT_-YaMOwdiyoQtewdMELh_QnV3" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1dHIwBLT_-YaMOwdiyoQtewdMELh_QnV3" -O /home/lemp/lempNEW.tar.gz  && rm -rf /tmp/cookies_lemp.txt
wget --load-cookies /tmp/cookies_lemp.txt "https://bitbucket.org/lempinfo/lempinfo/downloads/lempNEW.tar.gz" -O /home/lemp/lempNEW.tar.gz  && rm -rf /tmp/cookies_lemp.txt
sleep 1
 [[ ! -f /tmp/cookies_lemp.txt ]] && break
done
sleep 1
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


fi



if [ "$osrelease" == "24.04" ] ; then  
sudo apt install libzip4
apt install python3-pip -y
pip3 install gdown --break-system-packages  
 pip3 install --upgrade gdown   
/usr/local/bin/gdown --id  1Gzk0Siug-fcDdb5NfL1qWd5zkclPtkXH -O /home/lemp/lempNEW.tar.gz
sleep 1
tar -xvzf  /home/lemp/lempNEW.tar.gz -C /home/lemp
rm -r /home/lemp/lempNEW.tar.gz
sleep 2
 #export PATH="/home/lemp/node/bin:/home/lemp/php/bin:/home/lemp/openresty/bin:/home/lemp/openresty/nginx/sbin:/home/lemp/proftpd/sbin:$PATH"
 
 
rm -rf /home/lemp/script/lemp
mv /home/lemp/script/lemp2 /home/lemp/script/lemp
rm -r /home/lemp/script/mysql.server
rm -r /home/lemp/script/my.cnf
 

  fi
 



sudo chmod -R 755 /home/lemp/script/*
mv /home/lemp/script/* /etc/init.d/
sudo dpkg -i  /home/lemp/libicu52_52.1-3ubuntu0.4_amd64.deb
rm -r /home/lemp/*.deb
 
 if [ "$osrelease" == "18.04" ] || [ "$osrelease" == "19.04" ] || [ "$osrelease" == "20.04" ] ; then
wget -q -O /tmp/libicu60_60.2-3ubuntu3_amd64.deb https://github.com/lemp-info/lemp/raw/master/libicu60_60.2-3ubuntu3_amd64.deb && dpkg -i /tmp/libicu60_60.2-3ubuntu3_amd64.deb  && rm /tmp/libicu60_60.2-3ubuntu3_amd64.deb
wget -q -O /tmp/libonig4_6.7.0-1_amd64.deb https://github.com/lemp-info/lemp/raw/master/libonig4_6.7.0-1_amd64.deb && dpkg -i /tmp/libonig4_6.7.0-1_amd64.deb && rm /tmp/libonig4_6.7.0-1_amd64.deb
wget -q -O /tmp/libzip4_1.0.1-0ubuntu1_amd64.deb https://github.com/lemp-info/lemp/raw/master/libzip4_1.0.1-0ubuntu1_amd64.deb && dpkg -i /tmp/libzip4_1.0.1-0ubuntu1_amd64.deb  && rm /tmp/libzip4_1.0.1-0ubuntu1_amd64.deb
  fi
  
  
sudo apt-get -y  clean
sudo apt-get install  -y  -f
sudo dpkg --configure -a
  

if [ "$PHPV" == "2" ]   ; then
sudo  rm -rf /home/lemp/php 
 while true; do
#sudo wget --load-cookies /tmp/cookies_lempphp.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies_lempphp.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=19LMjVBWo98ouGrHQW-znaMn3-Cjspnqk" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=19LMjVBWo98ouGrHQW-znaMn3-Cjspnqk" -O /home/lemp/php.tar.gz  && rm -rf /tmp/cookies_lempphp.txt
sudo wget --load-cookies /tmp/cookies_lempphp.txt "https://bitbucket.org/lempinfo/lempinfo/downloads/php-7.4.16_ubntu18.04.tar.gz" -O /home/lemp/php.tar.gz  && rm -rf /tmp/cookies_lempphp.txt
sleep 1
 [[ ! -f /tmp/cookies_lempphp.txt ]] && break
done
sudo tar -xvzf  /home/lemp/php.tar.gz -C /home/lemp
sudo rm -r /home/lemp/php.tar.gz
fi

if [ "$PHPV" == "3" ]   ; then
   while true; do
#sudo wget --load-cookies /tmp/cookies_lempphp.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies_lempphp.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=14RJe1waFVq8JKxXZDnFhwemTw_tnzzzT" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=14RJe1waFVq8JKxXZDnFhwemTw_tnzzzT" -O /home/lemp/php.tar.gz  && rm -rf /tmp/cookies_lempphp.txt
sudo wget --load-cookies /tmp/cookies_lempphp.txt "https://bitbucket.org/lempinfo/lempinfo/downloads/php-8.0.3_ubntu18.04.tar.gz" -O /home/lemp/php.tar.gz  && rm -rf /tmp/cookies_lempphp.txt
sleep 1
 [[ ! -f /tmp/cookies_lempphp.txt ]] && break
done
sudo tar -xvzf  /home/lemp/php.tar.gz -C /home/lemp
sudo rm -r /home/lemp/php.tar.gz 
    
fi




if [ "$osrelease" == "19.04" ] || [ "$osrelease" = "20.04" || [ "$osrelease" = "16.04" ] || [ "$osrelease" = "18.04" ] ; then  
sudo ln -s /home/lemp/php/bin/* /usr/bin
if [[ $openssl != *"1.1.1"* ]]; then
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
  fi


sudo chown lemp:lemp /home/lemp
sudo chown lemp:lemp /home/lemp/*
 
   fi  
   
 

if [ "$osname" == "CentOS" ]; then
yum remove  -y httpd
yum istall  -y wget
yum -y install libxml2 libxml2-devel
yum -y install bzip2 bzip2-devel
yum -y install curl-devel
yum -y install libjpeg-turbo-devel
yum -y install libpng-devel
yum -y install freetype-devel
yum -y install epel-release
yum -y install uw-imap-devel libc-client
yum -y install postgresql-devel
yum -y install libxslt.x86_64 libxslt-devel.x86_64
yum -y install llibssh2-devel
yum -y install autoconf
yum -y install pcre-devel
yum -y install git libssh2-devel gcc-c++
yum install -y libzip-devel
if [[ $osrelease  = "7."* ]] ; then 
yum install https://github.com/lemp-info/lemp/raw/master/oniguruma-5.9.5-3.el7.x86_64.rpm -y
yum install https://github.com/lemp-info/lemp/raw/master/oniguruma-devel-5.9.5-3.el7.x86_64.rpm -y
cd /root
yum remove -y libzip
wget https://github.com/lemp-info/lemp/raw/master/script/libzip-1.2.0.tar.gz  -P /root
#wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=1QzWUFvZ6QCaHISVyOEsgrxlW9bm7LaMR" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1QzWUFvZ6QCaHISVyOEsgrxlW9bm7LaMR" -O /roor/libzip-1.2.0.tar.gz  && rm -rf /tmp/cookies.txt
tar -zxvf libzip-1.2.0.tar.gz
cd libzip-1.2.0
./configure
sleep 1
make && make install
sleep 2
echo '/usr/local/lib64
/usr/local/lib
/usr/lib
/usr/lib64'>>/etc/ld.so.conf
rm -r -f /root/ibzip-1.2.0.tar.gz
rm -r -f /root/ibzip-1.2.0
yum install -y libzip-devel
fi
if [[ $osrelease  = "8."* ]] ; then 
yum install https://github.com/lemp-info/lemp/raw/master/oniguruma-6.8.2-1.el8.x86_64.rpm -y
fi
while true; do
wget https://github.com/lemp-info/lemp/raw/master/script/lemp-CentOS.tar.gz -P /home/lemp
sleep 1
 [ -f /home/lemp/lemp-CentOS.tar.gz ] && break
done
#wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=1nF3EdYIVzNc4Hos2zzfR_XTj1vshPgtd" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1nF3EdYIVzNc4Hos2zzfR_XTj1vshPgtd" -O /home/lemp/lemp-CentOS.tar.gz  && rm -rf /tmp/cookies.txt
wget --load-cookies /tmp/cookies.txt "https://bitbucket.org/lempinfo/lempinfo/downloads/lemp-CentOS-platform_.tar.gz" -O /home/lemp/lemp-CentOS.tar.gz  && rm -rf /tmp/cookies.txt
tar -xvzf  /home/lemp/lemp-CentOS.tar.gz -C /home/lemp
rm -rf /home/lemp/lemp-CentOS.tar.gz
sudo chmod -R 755 /home/lemp/start-stop-daemon
mv /home/lemp/start-stop-daemon /usr/sbin/
if [ $MariaDB != "y" ];then
rm -rf /home/lemp/script/mysql.server
fi
sudo chmod -R 755 /home/lemp/script/*
cp /home/lemp/script/mysql.server /etc/rc.d/init.d/
mv /home/lemp/script/* /etc/rc.d/rc0.d/

if [[ $osrelease  = "7."* ]] ; then 
while true; do
#wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=12Aij97O48EH4C14yH_CVQ3yV2ECxh6Og" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=12Aij97O48EH4C14yH_CVQ3yV2ECxh6Og" -O /home/lemp/lempCentOS7PHP.tar.gz  && rm -rf /tmp/cookies.txt
wget --load-cookies /tmp/cookies.txt "https://bitbucket.org/lempinfo/lempinfo/downloads/lempCentOS7PHP.tar.gz" -O /home/lemp/lempCentOS7PHP.tar.gz  && rm -rf /tmp/cookies.txt
 sleep 1
 [ -f /home/lemp/lempCentOS7PHP.tar.gz ] && break
done
sudo chmod -R 755 /home/lemp/lempCentOS7PHP.tar.gz
tar -xvzf /home/lemp/lempCentOS7PHP.tar.gz -C /home/lemp/
rm -rf /home/lemp/lempCentOS7PHP.tar.gz
fi

if [[ $osrelease  = "8."* ]] ; then 
while true; do
#wget --load-cookies /tmp/cookies_lempCentOS8PHP.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies_lempCentOS8PHP.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=1k05pv6PIfn0TcgJk5jXyWrqYrI0LtXEF" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1k05pv6PIfn0TcgJk5jXyWrqYrI0LtXEF" -O /home/lemp/lempCentOS8PHP.tar.gz  && rm -rf /tmp/cookies_lempCentOS8PHP.txt
 wget --load-cookies /tmp/cookies_lempCentOS8PHP.txt "https://bitbucket.org/lempinfo/lempinfo/downloads/lempCentOS8PHP.tar.gz" -O /home/lemp/lempCentOS8PHP.tar.gz  && rm -rf /tmp/cookies_lempCentOS8PHP.txt
 sleep 1
 [[ ! -f /tmp/cookies_lempCentOS8PHP.txt ]] && break
done
sudo chmod -R 755 /home/lemp/lempCentOS8PHP.tar.gz
tar -xvzf /home/lemp/lempCentOS8PHP.tar.gz -C /home/lemp/
rm -rf /home/lemp/lempCentOS8PHP.tar.gz
yum install -y openssl-devel
fi


fi



sudo mv /home/lemp/phpmyadmin/phpmyadmin.sql /home/lemp/
sudo mv /home/lemp/phpmyadmin/config.inc.php /home/lemp/
sudo rm -rf /home/lemp/phpmyadmin
sleep 1
while true; do
sudo wget https://files.phpmyadmin.net/phpMyAdmin/5.2.3/phpMyAdmin-5.2.3-all-languages.tar.gz  -P /home/lemp/ 
 sleep 1
 [ -f /home/lemp/phpMyAdmin-5.2.3-all-languages.tar.gz ] && break
done
sleep 1
sudo chmod -R 755 /home/lemp/phpMyAdmin-5.2.3-all-languages.tar.gz
sleep 1
sudo tar -xvzf /home/lemp/phpMyAdmin-5.2.3-all-languages.tar.gz -C /home/lemp/
sleep 0
sudo rm -rf /home/lemp/phpMyAdmin-5.2.3-all-languages.tar.gz
sudo mv /home/lemp/phpMyAdmin-5.2.3-all-languages /home/lemp/phpmyadmin
sudo mv /home/lemp/phpmyadmin.sql /home/lemp/phpmyadmin/
sudo mv /home/lemp/config.inc.php /home/lemp/phpmyadmin/
sudo mkdir /home/lemp/phpmyadmin/tmp


 

if [ $MariaDB = "y" ]  && [ "$osrelease" != "24.04" ]  ;then
while true; do
sudo wget https://archive.mariadb.org//mariadb-10.5.0/bintar-linux-systemd-x86_64/mariadb-10.5.0-linux-systemd-x86_64.tar.gz -P /home/lemp/ 
sleep 1
[ -f /home/lemp/mariadb-10.5.0-linux-systemd-x86_64.tar.gz ] && break
done
sudo tar -xvf /home/lemp/mariadb-10.5.0-linux-systemd-x86_64.tar.gz -C /home/lemp 
sudo mv  /home/lemp/mariadb-10.5.0-linux-systemd-x86_64 /home/lemp/mysql
sudo rm -rf /home/lemp/mariadb-10.5.0-linux-systemd-x86_64.tar.gz
sudo rm -rf /home/lemp/mysql/support-files/mysql.server
sudo chmod -R 755 /etc/init.d/mysql.server
sudo cp /etc/init.d/mysql.server /home/lemp/mysql/support-files/
sudo chmod -R 755 /home/lemp
sudo chmod -R 755 /home/lemp/mysql
sleep 1
export PATH=/home/lemp/mysql/bin:$PATH
sleep 1
sudo chown -R mysql.mysql /home/lemp/mysql
sudo rm -rf /home/lemp/mysql/data
sleep 1
sudo /home/lemp/mysql/scripts/mysql_install_db --user=mysql --basedir=/home/lemp/mysql/ --datadir=/home/lemp/mysql/data
echo -e " \n "
sleep 1
#sudo /home/lemp/mysql/bin/mysqld_safe --user=mysql --basedir=/home/lemp/mysql/ --datadir=/home/lemp/mysql/data &
echo -e " \n "
sleep 1
sudo ln -s /home/lemp/mysql/bin/* /usr/local/bin/
sleep 1
sudo mv /etc/my.cnf /etc/my.cnf-old
sleep 1
sudo chmod -R 755 /home/lemp/mysql/support-files/mysql.server
sleep 1
 sudo chown -R  mysql:mysql /home/lemp/mysql
 sleep 1
sudo /home/lemp/mysql/support-files/mysql.server start
sleep 1
sudo /home/lemp/mysql/bin/mysqladmin -u root password "$SQL"
sleep 1
mysql -uroot -p"$SQL" -e "CREATE DATABASE phpmyadmin"  
mysql -uroot -p"$SQL" phpmyadmin < /home/lemp/phpmyadmin/phpmyadmin.sql 
fi
  
  
  
   
  
  
if  [ "$osrelease" = "24.04" ]  ;then

 if [ $MariaDB = "y" ]     ;then
# ==========================================================
# HARDCODED INSTALLER FOR UBUNTU 24.04 (No Variables)
# ==========================================================
cd

echo ">>> Cleaning up previous installs..."
systemctl stop mariadb 2>/dev/null
systemctl disable mariadb 2>/dev/null
rm -f /etc/systemd/system/mariadb.service
rm -f /root/.my.cnf
systemctl daemon-reload
pkill -f mariadbd 2>/dev/null
rm -rf /home/lemp/mysql

echo ">>> Installing dependencies..."
 sleep 1
apt-get install -y  tar    
apt-get install -y libaio1t64  
apt-get install -y  acl


echo ">>> Fixing libncurses5 library issue..."
wget -q http://launchpadlibrarian.net/648013231/libtinfo5_6.4-2_amd64.deb
wget -q http://launchpadlibrarian.net/648013227/libncurses5_6.4-2_amd64.deb
dpkg -i libtinfo5_6.4-2_amd64.deb libncurses5_6.4-2_amd64.deb
rm -f libtinfo5_6.4-2_amd64.deb libncurses5_6.4-2_amd64.deb


echo ">>> Setting up user and directories..."
groupadd -f mysql
useradd -r -g mysql -s /bin/bash mysql 2>/dev/null || true
mkdir -p /home/lemp/mysql/data

echo ">>> Downloading MariaDB..."
wget -O mariadb.tar.gz https://archive.mariadb.org/mariadb-10.11.6/bintar-linux-systemd-x86_64/mariadb-10.11.6-linux-systemd-x86_64.tar.gz

echo ">>> Extracting files..."
tar -xf mariadb.tar.gz -C /home/lemp/mysql --strip-components=1
rm -f mariadb.tar.gz

echo ">>> Setting permissions..."
sudo chown -R mysql:mysql /home/lemp/mysql
sudo chmod 755 /home/lemp/mysql
sudo chmod +x /home/lemp
chown -R mysql:mysql /home/lemp/mysql
setfacl -m u:mysql:rx /home/lemp

echo ">>> Initializing database..."
cd /home/lemp/mysql
su -s /bin/bash mysql -c "./scripts/mariadb-install-db --no-defaults --basedir=/home/lemp/mysql --datadir=/home/lemp/mysql/data --auth-root-authentication-method=normal"

echo ">>> Creating configuration file..."
cat > /home/lemp/mysql/my.cnf <<EOF
[client]
port = 3306
socket = /home/lemp/mysql/mysql.sock

[mysqld]
user = mysql
port = 3306
basedir = /home/lemp/mysql
datadir = /home/lemp/mysql/data
socket = /home/lemp/mysql/mysql.sock
pid-file = /home/lemp/mysql/mysql.pid
bind-address = 0.0.0.0
log-error = /home/lemp/mysql/mariadb.err
lc-messages-dir = /home/lemp/mysql/share
lc-messages = en_US
max_connections = 500
innodb_buffer_pool_size = 256M
EOF
chown mysql:mysql /home/lemp/mysql/my.cnf

echo ">>> Creating Systemd service..."
cat > /etc/systemd/system/mariadb.service <<EOF
[Unit]
Description=MariaDB Database Server (Custom Install)
After=network.target

[Service]
Type=simple
User=mysql
Group=mysql
ExecStart=/home/lemp/mysql/bin/mariadbd --defaults-file=/home/lemp/mysql/my.cnf
TimeoutSec=300
PrivateTmp=true
Restart=on-failure
ProtectHome=false

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable mariadb
systemctl start mariadb
sleep 5

echo ">>> Finalizing..."
if systemctl is-active --quiet mariadb; then
    # Set Root Password to 'fardin'
    /home/lemp/mysql/bin/mariadb-admin -u root --socket=/home/lemp/mysql/mysql.sock password "$SQL"
    
    # Create auto-login config for root
    cat > /root/.my.cnf <<EOF
[client]
socket=/home/lemp/mysql/mysql.sock
user=root
password=$SQL
EOF
    chmod 600 /root/.my.cnf
    
sudo ln -s /home/lemp/mysql/bin/* /usr/local/bin/

    echo "? SUCCESS! Connected via: mysql-custom"
else
    echo "? FAILED. Check log: /home/lemp/mysql/mariadb.err"
fi


sleep 2
mysql -uroot -p"$SQL" -e "CREATE DATABASE phpmyadmin"  
mysql -uroot -p"$SQL" phpmyadmin < /home/lemp/phpmyadmin/phpmyadmin.sql 

fi





 if [ $mongoDB = "y" ]     ;then

# ==========================================================
# FINAL REPAIRED INSTALLER - MongoDB 7.0
# Logic: Clean Install -> Start NoAuth -> Create User -> Enable Auth
# ==========================================================

# --- Variables ---
INSTALL_DIR="/home/lemp/mongodb"
DATA_DIR="$INSTALL_DIR/data"
LOG_DIR="$INSTALL_DIR/log"
CONFIG_FILE="$INSTALL_DIR/mongod.conf"
USER="mongodb"
GROUP="mongodb"
 

 
MONGO_VER="7.0.14"
MONGO_URL="https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2204-${MONGO_VER}.tgz"
SHELL_VER="2.3.8"
SHELL_URL="https://downloads.mongodb.com/compass/mongosh-${SHELL_VER}-linux-x64-openssl3.tgz"

# --- 1. CLEANUP (Factory Reset) ---
echo ">>> [1/8] Wiping previous installation..."
systemctl stop mongodb 2>/dev/null
pkill -f mongod 2>/dev/null
rm -f /etc/systemd/system/mongodb.service
systemctl daemon-reload

# ?????: ???? ???? ??? ?????? ?? ???? ???? ?? ???
if [ -d "$INSTALL_DIR" ]; then
    echo ">>> Removing old data to ensure clean user creation..."
    rm -rf "$INSTALL_DIR"
fi

# --- 2. Dependencies ---
echo ">>> [2/8] Installing Dependencies..."
apt-get update
apt-get install -y wget tar libcurl4 libgssapi-krb5-2 openssl acl

# --- 3. User Setup ---
echo ">>> [3/8] Setting up User..."
groupadd -f "$GROUP"
if ! getent passwd "$USER" > /dev/null 2>&1; then
    useradd -r -g "$GROUP" -s /bin/false "$USER"
fi

mkdir -p "$DATA_DIR"
mkdir -p "$LOG_DIR"

# --- 4. Download ---
echo ">>> [4/8] Downloading Files..."
wget -q --show-progress -O mongodb.tgz "$MONGO_URL"
tar -xf mongodb.tgz -C "$INSTALL_DIR" --strip-components=1
rm -f mongodb.tgz

wget -q --show-progress -O mongosh.tgz "$SHELL_URL"
mkdir -p /tmp/mshell
tar -xf mongosh.tgz -C /tmp/mshell --strip-components=1
mv /tmp/mshell/bin/mongosh "$INSTALL_DIR/bin/"
rm -rf /tmp/mshell mongosh.tgz

# --- 5. Config (Phase 1: NO AUTH) ---
echo ">>> [5/8] Configuring (Security Disabled initially)..."

cat > "$CONFIG_FILE" <<EOF
storage:
  dbPath: $DATA_DIR

systemLog:
  destination: file
  logAppend: true
  path: $LOG_DIR/mongod.log

net:
  port: 27017
  bindIp: 0.0.0.0

processManagement:
  timeZoneInfo: /usr/share/zoneinfo
EOF

# Permissions
chown -R "$USER":"$GROUP" "$INSTALL_DIR"
setfacl -m u:"$USER":rx /home/lemp

# Systemd Service
cat > /etc/systemd/system/mongodb.service <<EOF
[Unit]
Description=MongoDB Server
After=network.target

[Service]
User=$USER
Group=$GROUP
Environment="PATH=$INSTALL_DIR/bin:/usr/bin:/bin"
ExecStart=$INSTALL_DIR/bin/mongod --config $CONFIG_FILE
Restart=on-failure
ProtectHome=false

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable mongodb
systemctl start mongodb

# Symlinks
ln -sf "$INSTALL_DIR/bin/mongosh" /usr/local/bin/mongosh
ln -sf "$INSTALL_DIR/bin/mongod" /usr/local/bin/mongod

echo ">>> Waiting for MongoDB to initialize..."
sleep 10

# --- 6. Create User ---
echo ">>> [6/8] Creating Admin User..."

# ???? ?? mongosh (??? ???? ????? ???????? ???? ??? ????)
"$INSTALL_DIR/bin/mongosh" admin --eval "db.createUser({user: 'admin', pwd: '$PASSMONGO', roles: [{role: 'root', db: 'admin'}]})"

if [ $? -ne 0 ]; then
    echo "? CRITICAL: Failed to create user. Check logs."
    cat "$LOG_DIR/mongod.log"
    exit 1
fi

# --- 7. Enable Security (Phase 2) ---
echo ">>> [7/8] Enabling Security & Restarting..."
systemctl stop mongodb

# ????? ???? ??? ????? ?? ???? ??????
cat >> "$CONFIG_FILE" <<EOF

security:
  authorization: enabled
EOF

systemctl start mongodb
sleep 5

# --- 8. Verify ---
echo ">>> [8/8] Testing Connection..."

if systemctl is-active --quiet mongodb; then
    echo "=================================================="
    echo "? INSTALLATION COMPLETE!"
    echo "User: admin"
    echo "Pass: $PASSMONGO"
    echo "--------------------------------------------------"
    echo "Test Command:"
    echo "mongosh -u admin -p $PASSMONGO --authenticationDatabase admin"
    echo "=================================================="
else
    echo "? Final restart failed. Check log:"
    cat "$LOG_DIR/mongod.log"
fi

fi



fi

if [ "$osname" == "Ubuntu" ] ; then
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
 
sudo chmod +x /etc/rc.local  
fi
sudo rm -r /home/lemp/openssl-1.1.1c > /dev/null 2>&1
sudo rm -r /home/lemp/openssl-1.1.1c.tar.gz > /dev/null 2>&1
sudo sudo /etc/init.d/lemp start
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

sed -i 's/50x.html/50x.php/g' /home/lemp/nginx/conf/nginx.conf
sed -i 's/50x.html/50x.php/g' /home/lemp/openresty/nginx/conf/nginx.conf


sleep 1
sudo chmod 755 /home/lemp/phpmyadmin/tmp
sudo chmod 777 /home/lemp/phpmyadmin/tmp 
sudo chmod 755 /home/lemp/phpmyadmin/config.inc.php
sleep 2
sudo rm -rf /home/lemp/www/*
while true; do
sudo wget  https://github.com/lemp-info/lemp/raw/master/script/lempweb.tar.gz -P /home/lemp/www 
sleep 1
 [ -f /home/lemp/www/lempweb.tar.gz ] && break
done
sleep 1
sudo tar -xvf /home/lemp/www/lempweb.tar.gz -C /home/lemp/www
sudo rm -rf /home/lemp/www/lempweb.tar.gz
sudo ln -s /home/lemp/phpmyadmin /home/lemp/www/phpmyadmin


if [ $MariaDB != "y" ]; then
if [ $mysqlstatus = "y" ]; then
if (whiptail --title "database phpmyadmin." --yesno "Do you want to install database phpmyadmin ?" 8 78); then   
phpmyadmin="y"
else
phpmyadmin="n"	 
fi 
if [ $phpmyadmin = "y" ];then
while true; do
 echo 
mysqlpassword=$(whiptail --title "MariaDB Password" --passwordbox "Please enter your mysql password." 10 60 3>&1 1>&2 2>&3)
 echo 
RESULT=`mysqlshow --user=root --password=$mysqlpassword mysql | grep -v Wildcard | grep -o mysql `
[ "$RESULT" = "mysql" ] && break
done
mysql -uroot -p"$mysqlpassword" -e "CREATE DATABASE phpmyadmin"  
mysql -uroot -p"$mysqlpassword" phpmyadmin < /home/lemp/phpmyadmin/phpmyadmin.sql 
fi 
fi
fi

 

if (whiptail --title "Restart." --yesno "Do you want to restart now ?" 8 78); then   
reboot
else
echo " "   	
fi 

echo -e "${jeshile}Done.${jo}"
