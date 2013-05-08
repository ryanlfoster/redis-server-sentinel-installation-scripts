#!/bin/bash
# From https://raw.github.com/nillis/redis-server-sentinel-installation-scripts/master/redis-remove-script.sh
###############################################
# To use: 
# git clone https://github.com/nillis/redis-server-sentinel-installation-scripts.git
# sudo sh redis-remove-script.sh
echo "*****************************************"
echo " 1. Stop Redis Server and Redis Sentinel"
echo "*****************************************"
sudo service redis-server start
sudo service redis-sentinel start
echo "*****************************************"
echo " 2. Remove Auto-Enable Redis-Server and Redis-Sentinel"
echo "*****************************************"
sudo chkconfig --del redis-server
sudo chkconfig --del redis-sentinel
echo "*****************************************"
echo " 3. Remove Directories and Files"
echo "*****************************************"
sudo rm -rf /etc/redis-server /etc/redis-sentinel /var/lib/redis
sudo rm -rf /usr/local/bin/redis-server /usr/local/bin/redis-cli /usr/local/bin/redis-sentinel 
sudo rm -rf  /etc/init.d/redis-server
sudo rm -rf /etc/init.d/redis-sentinel
echo "*****************************************"
echo " Uninstall Complete!"
read -p "Press [Enter] to continue..."