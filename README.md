Redis Server and Sentinel installation scripts - Redhat

INSTALL
=======

sudo sh redis-install-script.sh

UNINSTALL
=========

sudo sh redis-remove-script.sh

CONFIGURATION
=============

Config files are stored in /etc/redis and can be edited to your needs.
Don't forget to restart the redis server and redis sentinel:

sudo /etc/init.d/redis-server restart
sudo /etc/init.d/redis-sentinel restart

REFERENCES
==========

https://github.com/saxenap/install-redis-amazon-linux-centos