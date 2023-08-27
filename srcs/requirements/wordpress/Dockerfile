FROM	debian:buster
#RUN	apt-get -o Acquire::Check-Valid-Until="false" update
RUN	apt-get install -y apt-transport-https && apt-get update

# Dossier de travail de wordpress (dans le container)
WORKDIR	/var/www/html/wordpress

# du coup ici:
# wget: permet dinstaller des trucs via une URL
# php-fpm: fast cgi process manager
# mariadb-client : dependance de php-mysql ?
RUN	apt-get -y install wget php7.3-fpm php7.3-common php-mysql mariadb-client

# Wordpress client
RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	chmod +x wp-cli.phar
RUN	cp wp-cli.phar /usr/local/bin/wp

#
COPY	./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY	./tools /var/www/html
RUN	chmod +x /var/www/html/wordpress_start.sh
RUN	ls /var/www/html
EXPOSE	9000

# RUN sed -i 's/listen = \/run\/php\/php7\.3-fpm\.sock/listen = wordpress:9000/g' /etc/php/7.3/fpm/pool.d/www.conf
# ENTRYPOINT EST IGNORE PAR DOCKERCOMPOSE, mais utilise par Docker
# pcq on veut quand meme pouvoir entrer dans le container isole
# CMD peut etre override par Docker CLI, alors que entrypoint non
# Pratique de mettre les deux car CMD definit le comportement par defaut, mais 
# peut etre overriden et seulement utilise entrypoint
RUN		echo "ON LANCE LE SCRIPT"
ENTRYPOINT	["bash", "/var/www/html/wordpress_start.sh"]

RUN	echo "SCRIPT A ETE LANCE et finito"
CMD		["/usr/sbin/php-fpm7.3", "--nodaemonize"]
