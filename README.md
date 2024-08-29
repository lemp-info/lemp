# lemp 
## What’s a LEMP stack?
LEMP is a variation of the ubiquitous LAMP stack used for developing and deploying web applications. Traditionally, LAMP consists of Linux, Apache, MySQL, and PHP. Due to its modular nature, the components can easily be swapped out. With LEMP, Apache is replaced with the lightweight yet powerful Nginx.
## lemp.info
    We tried to create an easy script to install. In short time everything is installed. 
    To host projects on a Linux server system. 
    Our goal is to teach programming and web hosting    

## install:
     sudo wget https://raw.githubusercontent.com/lemp-info/lemp/master/lemp.sh && sudo chmod a+x lemp.sh && ./lemp.sh
 
## Ubuntu NGINX MariaDB PHP & ProFTPD + phpMyAdmin
    nginx      Version 1.17.7
    PHP        Version 7.3.12
    MariaDB    Version 10.5.0 
    ProFTPD    Version 1.3.5
    phpmyadmin Version 4.9.4
    
## CentOS NGINX MariaDB PHP & ProFTPD + phpMyAdmin
    nginx      Version 1.17.7
    PHP        Version 7.3.19
    MariaDB    Version 10.5.0 
    ProFTPD    Version 1.3.5
    phpmyadmin Version 4.9.4
    
    
     
 ## addons   
    MySQL-5.5.62:
     sudo wget https://raw.githubusercontent.com/lemp-info/lemp/master/MySQL-5.5.62.sh && chmod a+x MySQL-5.5.62.sh && ./MySQL-5.5.62.sh
    
    MongoDB:  
     sudo wget https://raw.githubusercontent.com/lemp-info/lemp/master/mongodb.sh && chmod a+x mongodb.sh && ./mongodb.sh
     
     Node.js:
       wget https://sourceforge.net/projects/lemp-info/files/node.tar.gz -P /home/lemp/ && tar -xvzf  /home/lemp/node.tar.gz -C /home/lemp && rm -r /home/lemp/node.tar.gz && sudo ln -s /home/lemp/node/bin/* /usr/local/bin/  
       
     Turnserver:
         cd && rm -r -f /root/coturn && git clone https://github.com/coturn/coturn.git && cd coturn && ./configure --prefix=/home/lemp/turnserver && sudo make && sudo  make install && rm -r -f /usr/local/bin/turnadmin && rm -r -f  /usr/local/bin/turnserver && rm -r -f /usr/local/bin/turnutils_natdiscovery && rm -r -f /usr/local/bin/turnutils_oauth && rm -r -f  /usr/local/bin/turnutils_peer && rm -r -f  /usr/local/bin/turnutils_stunclient && rm -r -f  /usr/local/bin/turnutils_uclient && sudo ln -s /home/lemp/turnserver/bin/* /usr/local/bin/ && rm -r -f /root/coturn

     FFmpeg:
         wget https://sourceforge.net/projects/lemp-info/files/FFmpeg.tar.gz -P /home/lemp/ && tar -xvzf  /home/lemp/FFmpeg.tar.gz -C /home/lemp && rm -r /home/lemp/FFmpeg.tar.gz && sudo ln -s /home/lemp/FFmpeg/* /usr/local/bin/ 

     Anti-DDoS:
          wget --load-cookies /tmp/cookies_lemp.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies_lemp.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=1n3VClC_zAVOdrxCKJ1SqMiXZg3Q4Bfwf" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1n3VClC_zAVOdrxCKJ1SqMiXZg3Q4Bfwf" -O /home/lemp/ddos_deflate-0.7.tar.gz   && rm -rf /tmp/cookies_lemp.txt  && tar -xvzf  /home/lemp/ddos_deflate-0.7.tar.gz -C /home/lemp && rm -r  -f /home/lemp/ddos_deflate-0.7.tar.gz  && cd /home/lemp/ddos_deflate-0.7 &&  ./install.sh 
 
   
     
## update:
   
       # 2021/04/06
     1. added php-7.4.26 &  php-8.0.3 for ubuntu 18-19-20
       # 2020/05/09
     1.NGINX Internal Load Balancing PHP-FPM Upstream  'Faster'
     2.NGINX ssl config
     3.extension ioncube 
     4.extension ssh2 
     5.extension snuffleupagus ( To run, you must exit the comment in the file php.ini ";extension=snuffleupagus.so")
     7.Manual startup "/home/lemp/start.sh"
     
## Import database phpmyadmin (manually)

     mysql -uroot -p -e "CREATE DATABASE phpmyadmin"  
     mysql -uroot -p phpmyadmin < /home/lemp/phpmyadmin/phpmyadmin.sql 
## Path
     Lemp:           /home/lemp
     www:            /home/lemp/www 
     MariaDB my.cnf: /home/lemp/mysql/my.cnf
     
 ## Ubuntu & ZorinOS Usage : 
     sudo /etc/init.d/lemp           {start|stop|restart|status}
     sudo /etc/init.d/nginx          {start|stop|restart|status}
     sudo /etc/init.d/php            {start|stop|restart|status}
     sudo /etc/init.d/mysql.server   {start|stop|restart|status}
     sudo /etc/init.d/proftpd        {start|stop|restart|status}
     
 ## CentOS Usage : 
     sudo /etc/rc0.d/lemp           {start|stop|restart|status}
     sudo /etc/rc0.d/nginx          {start|stop|restart|status}
     sudo /etc/rc0.d/php            {start|stop|restart|status}
     sudo /etc/init.d/mysql.server  {start|stop|restart|status}
     sudo /etc/rc0.d/proftpd        {start|stop|restart|status}
     
     
## phpMyAdmin
     http://ipaddress/phpmyadmin
     username: root
     password: mysql password

## MongoAdmin
     sudo wget https://raw.githubusercontent.com/lemp-info/lemp/master/mongoadmin.tar.gz -P /home/lemp/ && tar -xvzf  /home/lemp/mongoadmin.tar.gz -C /home/lemp && rm -r /home/lemp/mongoadmin.tar.gz && sudo ln -s /home/lemp/mongoadmin /home/lemp/www/mongoadmin

        
## how to login to proftpd server ( FTP )
     1. set password for user lemp: sudo passwd lemp
     2. ftp://ipadderss/ 
     username: lemp or root
     password: lemp password or root password
     
## Set MariaDB root password 
     mysql -u root
     
     use mysql;
     delete from user where User='root';
     DELETE FROM mysql.user WHERE User='';
     flush privileges;
     grant all privileges on *.* to 'root'@'localhost' identified by 'NewPassword' with grant option;
     grant all privileges on *.* to 'root'@'127.0.0.1' identified by 'NewPassword' with grant option;
     grant all privileges on *.* to 'root'@'::1' identified by 'NewPassword' with grant option;
     flush privileges;
     \q
     
 
### nginxfriends@gmail.com

### Donate 
 
### DogeCoin Wallet = DJfqwVRCpWVxg2jSp1TQwWQc2VH6udzTPr
