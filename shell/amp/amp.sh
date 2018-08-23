#!/bin/bash
echo off
echo ''
echo '<><><><><><><>< A M P + ><><><><><><><>'
echo '><><>< Apache2 MySql PhP + extra ><><><'
echo '<><><><><><><><><>< ><><><><><><><><><>'
echo ''
echo 'It is VERY recomended to run this script on FRESH OS install'
sleep 5
echo ''
echo Starting setup for:
echo ''
echo '- Services'
echo '  `- MySql'
echo '  `- Apache2'
echo '- Languages' 
echo '  `- php 7.0'
echo '    `- modules'
echo '      `- libapache2-mod'
echo '      `- php7.0-cli'
echo '      `- php7.0-common'
echo '      `- php7.0-curl'
echo '      `- php7.0-json'
echo '      `- php7.0-mysql'
echo '      `- php7.0-pgsql'
echo '      `- php7.0-phpdbg'
echo '      `- php7.0-sqlite3'
echo '      `- php7.0-xml'
echo '      `- php7.0-zip'
echo '- Additional apps'
echo '  `- Apps'
echo '    `- zip'
echo '    `- unzip'
echo '    `- htop'
echo '  `- Text Editors'
echo '    `- vim'
echo '    `- nano'
echo '  `- Security'
echo '    `- fail2ban'
echo '- Web Content'
echo '  `- *MySql user'
echo '  `- phpInfo'
echo '  `- WordPress'
echo '    `- *MySql database'
echo '  `- Joomla!'
echo '    `- *MySql database'
echo ' '
read -p 'Press enter to start with the installation. If you do not want to continue, press "ctrl + c"'
echo ' '
sleep 3
echo '> Starting Services installation'
echo '  `- Starting Apache2 installation ...'
sleep 2 && apt-get install apache2 -y -qq > /dev/null
echo '  `- Starting MySql database server installation ...'
echo '     During this installation you will have to set password for administrative account for this database system! DO remember it!'
echo ''
echo 'Do you want to run a fresh install and secure, which will remove everything related to MySql server?'
echo 'Keep in mind taht it is not recomended to run this, until you ave a MySql server installed already, OR if you have it, but you have databases that you do not want to lose'
echo ''
echo 'THIS WILL REMOVE EVERYTHING RELATED TO MYSQL, INCLUDING DEPENDECIES FOR OTHER SERVICES! THINK TWICE BEFORE YOU RUN IT!'
echo ''
echo 'Run fresh install? (yes / no)'
read removemysql
echo ''
if [ "$removemysql" == "yes" ]; then
  echo 'Removing everything related to MySql'
  apt-get remove --purge *mysql\* -y
else
  echo 'You skipped the MySql-fresh install'
fi
echo ''
sleep 2 && apt-get install mysql-server -y
echo '> Starting Languages installation'
echo '  `- Starting php7.0 installation ...'
sleep 2 && apt-get install php7.0 -y -qq > /dev/null
echo '     `- Starting modules installation ...'
sleep 2
apt-get install libapache2-mod-php7.0 -y -qq > /dev/null
apt-get install php7.0-cli -y -qq > /dev/null
apt-get install php7.0-common -y -qq > /dev/null
apt-get install php7.0-cli -y -qq > /dev/null
apt-get install php7.0-curl -y -qq > /dev/null
apt-get install php7.0-json -y -qq > /dev/null
apt-get install php7.0-mysql -y -qq > /dev/null
apt-get install php7.0-pgsql -y -qq > /dev/null
apt-get install php7.0-phpdbg -y -qq > /dev/null
apt-get install php7.0-sqlite3 -y -qq > /dev/null
apt-get install php7.0-xml -y -qq > /dev/null
apt-get install php7.0-zip -y -qq > /dev/null
echo '> Starting Additional apps installation'
echo '  `- Apps'
echo '    `- Starting unzip installation'
sleep 2 && apt-get install zip -y -qq -qq > /dev/null
echo '    `- Starting zip installation'
sleep 2 && apt-get install zip -y -qq > /dev/null
echo '    `- Starting htop installation'
sleep 2 && apt-get install htop -y -qq > /dev/null
echo '  `- Text Editors'
echo '    `- Starting Vim installation'
sleep 2 && apt-get install vim -y -qq > /dev/null
echo '    `- Starting nano installation'
sleep 2 && apt-get install nano -y -qq > /dev/null
echo '  `- Security'
echo '    `- Starting fail2ban installation'
sleep 2 && apt-get install fail2ban -y -qq > /dev/null
echo '>>> Main software installed!'


sleep 5
echo ' '
echo '> Starting Web Content installation'
echo '  `- *MySql user, username: "webmaster"'
echo ''
echo 'Enter password for "root" MySql account. Use the password you set during software installation. When inserted, press enter.'
read rootpw
echo ''
echo 'Set password for "webmaster" MySql account. When inserted, press enter.'
read webmpass
echo ''
mysql -uroot -p$rootpw --silent -e "CREATE USER 'webmaster'@'localhost' IDENTIFIED BY '"$webmpass"';"
echo ''
echo 'Password for user "webmaster" has been set to "'$webmpass'". Note that down before you continue!'
sleep 3
read -p "Press enter to continue"
sleep 2
echo '  `- phpinfo'
sleep 1
cd /var/www/html
rm index.html
touch index.php
echo "<?php phpinfo(); ?>" > index.php
echo '    `- File "index.php" has been created in directory /var/www/html'
echo '       Connect to it using any browser while navigating to http://localhost'
sleep 5
echo '  `- wordpress'
sleep 1
wget https://wordpress.org/latest.tar.gz -q -O wordpress.tar.gz
tar -zxf wordpress.tar.gz
rm wordpress.tar.gz
echo '    `- Directory "wordpress" has been created, located /var/www/html/wordpress Connect to it using any browser while navigating to http://localhost/wordpress'
echo '    `- Creating wordpress database'
echo ' '
mysql -uroot -p$rootpw -e "create database wordpress";
mysql -uroot -p$rootpw -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'webmaster'@'localhost'";
sleep 5
echo ' '
echo '  `- Joomla!'
sleep 1
mkdir joomla
cd joomla
mkdir temp
cd temp
wget https://downloads.joomla.org/cms/joomla3/3-8-0/joomla_3-8-0-stable-full_package-zip?format=zip -q -O joomla.zip
mv joomla.zip ..
cd ..
rm -rf temp
unzip -qq joomla.zip
sleep 1
rm joomla.zip
cd ..
echo '    `- Directory "joomla" has been created, located /var/www/html/joomla Connect to it using any browser while navigating to http://localhost/joomla'
echo '    `- Creating joomla database'
echo ' '
mysql -uroot -p$rootpw -e "create database joomla";
mysql -uroot -p$rootpw -e "GRANT ALL PRIVILEGES ON joomla.* TO 'webmaster'@'localhost'";
chown -R www-data:www-data /var/www/html/joomla
chown -R www-data:www-data /var/www/html/wordpress
cd /root
touch info_amp+.txt
echo "MySql_root_pw: "$rootpw"  MySql_webadmin_pw: "$webmpass > info_amp+.txt
service apache2 restart
sleep 3
echo ''
echo 'END OF INSTALLATION!'
echo ''
echo 'Installations'
echo '- Services'
echo '  `- MySql'
echo '  `- Apache2'
echo '- Languages' 
echo '  `- php 7.0'
echo '    `- modules'
echo '      `- libapache2-mod'
echo '      `- php7.0-cli'
echo '      `- php7.0-common'
echo '      `- php7.0-curl'
echo '      `- php7.0-json'
echo '      `- php7.0-mysql'
echo '      `- php7.0-pgsql'
echo '      `- php7.0-phpdbg'
echo '      `- php7.0-sqlite3'
echo '      `- php7.0-xml'
echo '      `- php7.0-zip'
echo '- Additional apps'
echo '  `- Apps'
echo '    `- zip'
echo '    `- unzip'
echo '    `- htop'
echo '  `- Text Editors'
echo '    `- vim'
echo '    `- nano'
echo '  `- Security'
echo '    `- fail2ban'
echo '- Web Content'
echo '  `- phpInfo'
echo '  `- WordPress'
echo '  `- Joomla!'
echo ''
echo 'Final information'
echo '- MySql'
echo '  `- users'
echo '    `- root :' $rootpw
echo '    `- webmaster:' $webmpass
echo '  `- databases'
echo '    `- wordpress'
echo '    `- joomla'
echo '  `- address'
echo '    `- localhost'
echo '    `- 127.0.0.1'
echo ''
echo 'MySql passwords for root and webmaster were also saved in file located in /root/info_amp+.txt'
echo ''
echo 'End of installation script'
echo ''
echo ''
echo 'Script coded and provided by aljaxus'
echo 'Personal page: https://dev.aljaxus.eu'
echo ''
read -p "Press enter to exit the installation script."
