#!/bin/bash

if [ ! -d /var/lib/mysql/wordpress ]; then
	mysqld&
	until mysqladmin ping; do
		sleep 1
	done
	echo "create database if not exists wordpress;" | mysql -u root
	echo "create user if not exists '$LOGIN' identified by '$PASSWORD';" | mysql -u root
	echo "grant usage on wordpress.* TO '$LOGIN'@'%' identified by '$PASSWORD';" | mysql -u root
	echo "grant all privileges on wordpress.* TO '$LOGIN'@'%' with grant option;" | mysql -u root
	echo "flush privileges;" | mysql -u root
# Installation of MySQL creates only a 'root'@'localhost' superuser account that has all privileges
# and can do anything. If the root account has an empty password, your MySQL installation is unprotected: 
# Anyone can connect to the MySQL server as root without a password and be granted all privileges. 
# We must assign a new password for root :
	echo "alter user 'root'@'localhost' identified by '$PASSWORD';" | mysql -u root
	#innodb_fast_shutdown
	#rm -f /var/lib/mysql/ib_logfile0 /var/lib/mysql/ib_logfile1 
	killall mysqld

	#userdel mysql
	#useradd -u 999 mysql
fi

exec "$@"
