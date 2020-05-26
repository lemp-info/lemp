# lemp 
## What’s a LEMP stack?
LEMP is a variation of the ubiquitous LAMP stack used for developing and deploying web applications. Traditionally, LAMP consists of Linux, Apache, MySQL, and PHP. Due to its modular nature, the components can easily be swapped out. With LEMP, Apache is replaced with the lightweight yet powerful Nginx.
## lemp.info
    We tried to create an easy script to install. In short time everything is installed. 
    To host projects on a Linux server system. 
    Our goal is to teach programming and web hosting    

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
    
## install:
     wget https://raw.githubusercontent.com/lemp-info/lempNew/master/lemp.sh && chmod a+x lemp.sh && ./lemp.sh
     
     
 ## addons   
     Node.js:
      wget https://sourceforge.net/projects/lemp-info/files/node.tar.gz -P /home/lemp/ & tar -xvzf  /home/lemp/node.tar.gz -C /home/lemp & sudo ln -s /home/lemp/node/bin/* /usr/local/bin/ & rm -r /home/lemp/node.tar.gz


     Turnserver:
     
     Ffmpeg:
     
## update:
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
     
 ## Ubuntu Usage : 
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
        
## how to login to proftpd server ( FTP )
     1. set password for user lemp: sudo passwd lemp
     2. ftp://ipadderss/ 
     username: lemp
     password: lemp password
     
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
     
### www.lemp.info
### www.nginxfriends.org
### admin@lemp.info

### Donation 
http://bit.ly/34RjJrc
    1 KD = 3.29 USD
