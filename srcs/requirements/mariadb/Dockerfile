FROM	debian:buster

# Update & upgrade
RUN		apt-get -y update

# Telecharge et installe les services dont on aura besoin
RUN		apt-get -y install mariadb-server

# Ports that needs to be exposed at run time with -p [host port]:[container port]
EXPOSE	3306

# Mettre notre fichier de config de mariadb dans notre dossier de travail
COPY	./conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	./tools/mariadb_start.sh /var/www/mariadb_start.sh
#COPY	./tools/debug.sh /var/www/debug.sh

#RUN		userdel mysql
#RUN		useradd -u 999 mysql
#RUN		rm -rf /var/lib/mysql;
#RUN		mkdir -p var/lib/mysql var/run/mysqld;
RUN		mkdir -p /run/mysqld
#RUN		mkdir -p /var/lib/mysql
RUN		chown -R mysql:root /run/mysqld
RUN		chown -R mysql:mysql /var/lib/mysql
#RUN		chown -R root:mysql /var /var/lib
#RUN		chmod 755 /var/run/mysqld;

ENTRYPOINT ["bash", "/var/www/mariadb_start.sh"]

#RUN		userdel mysql
#RUN		useradd -u 999 mysql
#RUN		rm /var/lib/mysql/ib_logfile/*
#RUN		chown -R root:mysql /var /var/lib
#CMD		["bash", "/var/www/debug.sh"]
CMD		["mysqld"]
