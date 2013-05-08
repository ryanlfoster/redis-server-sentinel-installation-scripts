Redis Server and Sentinel installation scripts - Redhat

============
INSTALLATION
============

1. Move the files into a folder
2. sudo sh redis-install-script.sh

=============
CONFIGURATION
=============

Config files are stored in /etc/redis and can be edited to your needs.
Don't forget to restart the redis server and redis sentinel:

sudo /etc/init.d/redis-server restart
sudo /etc/init.d/redis-sentinel restart

==========
REFERENCES
==========

https://github.com/saxenap/install-redis-amazon-linux-centos