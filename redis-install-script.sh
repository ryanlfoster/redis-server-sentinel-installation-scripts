#!/bin/bash
# Based on https://github.com/saxenap/install-redis-amazon-linux-centos
# From https://raw.github.com/nillis/redis-server-sentinel-installation-scripts/master/redis-install-script.sh
# Uses redis-server init script from https://raw.github.com/nillis/redis-server-sentinel-installation-scripts/master/redis-server
# Uses redis-sentinel init script from https://raw.github.com/nillis/redis-server-sentinel-installation-scripts/master/redis-sentinel
###############################################
# To use: 
# git clone https://github.com/nillis/redis-server-sentinel-installation-scripts.git
# sudo sh redis-install-script.sh
echo "*****************************************"
echo " 1. Prerequisites: Install updates, set time zones, install GCC and make"
echo "*****************************************"
sudo yum -y update
sudo yum -y install gcc gcc-c++ make 
echo "*****************************************"
echo " 2. Download, Untar and Make Redis 2.6.13"
echo "*****************************************"
sudo wget http://download.redis.io/releases/redis-2.8.1.tar.gz
sudo tar xzf redis-2.8.1.tar.gz
sudo rm redis-2.8.1.tar.gz -f
cd redis-2.8.1
sudo make
sudo make install
echo "*****************************************"
echo " 3. Create Directories and Copy Redis Files"
echo "*****************************************"
sudo mkdir /etc/redis-server /etc/redis-sentinel /var/lib/redis-server /var/lib/redis-sentinel
sudo cp src/redis-server src/redis-cli src/redis-sentinel /usr/local/bin
sudo cp redis.conf /etc/redis-server
echo "*****************************************"
echo " 4. Configure Redis.Conf"
echo "*****************************************"
echo " Edit redis.conf as follows:"
echo " 1: ... daemonize yes"
echo " 2: ... bind 127.0.0.1"
echo " 3: ... dir /var/lib/redis-server"
echo " 4: ... loglevel notice"
echo " 5: ... logfile /var/log/redis-server.log"
echo "*****************************************"
sudo sed -e "s/^daemonize no$/daemonize yes/" -e "s/^# bind 127.0.0.1$/bind 127.0.0.1/" -e "s/^dir \.\//dir \/var\/lib\/redis-server\//" -e "s/^loglevel verbose$/loglevel notice/" -e "s/^logfile stdout$/logfile \/var\/log\/redis-server.log/" redis.conf > /etc/redis-server/redis.conf
echo "*****************************************"
echo " 5. Configure Sentinel.Conf"
echo "*****************************************"
echo " Edit sentinel.conf as follows:"
echo " 1: ... daemonize yes"
echo " 2: ... bind 127.0.0.1"
echo " 3: ... dir /var/lib/redis-sentinel"
echo " 4: ... loglevel notice"
echo " 5: ... logfile /var/log/redis-sentinel.log"
echo "*****************************************"
sudo echo "daemonize yes" >> sentinel.conf
sudo echo "dir /var/lib/redis-sentinel" >> sentinel.conf
sudo echo "loglevel notice" >> sentinel.conf
sudo echo "logfile /var/log/redis-sentinel.log" >> sentinel.conf
sudo cp sentinel.conf /etc/redis-sentinel
echo "*****************************************"
echo " 6. Move and Configure Redis-Server and Redis-Sentinel"
echo "*****************************************"
cd ..
sudo cp redis-server /etc/init.d
sudo cp redis-sentinel /etc/init.d
sudo chmod 755 /etc/init.d/redis-server
sudo chmod 755 /etc/init.d/redis-sentinel
echo "*****************************************"
echo " 7. Auto-Enable Redis-Server and Redis-Sentinel"
echo "*****************************************"
sudo chkconfig --add redis-server
sudo chkconfig --level 345 redis-server on
sudo chkconfig --add redis-sentinel
sudo chkconfig --level 345 redis-sentinel on
echo "*****************************************"
echo " Installation Complete!"
echo ""
echo " Configure redis-server in /etc/redis-server/redis.conf"
echo " Configure redis-sentinel in /etc/redis-sentinel/sentinel.conf"
echo ""
echo " To start redis-server execute /etc/init.d/redis-server start"
echo " To start redis-sentinel execute /etc/init.d/redis-sentinel start"
echo ""
read -p "Press [Enter] to continue..."

