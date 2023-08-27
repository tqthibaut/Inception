#!/bin/bash

mkdir -p /var/run/php/
#touch /var/run/php/php7.3-fpm.pid;

echo "TEST ENV == login:$LOGIN pass:$PASSWORD"
if [ -f ".installed" ]
then
	echo "Wordpress already installed"
else
	#mkdir -p /var/www/html/
	#chmod -R 755 /var/www/html
	#chown -R 1000:1000 /var/www/html
	#rm -f /var/www/html/wp-config.php
	#rm -f /var/www/html/wp-config-sample.php
	# Telechargement de WordPress
	wp core download --allow-root
	
# Creation de la config WordPress
#	--dbname : Init nom de la database
#	--dbuser : Init utilisateur
#	--dbpass : Init password
#	--dbhost : Init herbergeur de la database
#	--dbcharset : Init charset, encodage des characteres
#		--> bien preciser "utf8mb4" pour encodage sur 4 octets
#	--dbcollate : Init du code utiliser pour charset
#	--force : ecrase fichiers existant
#	--allow-root : autorise acces root
	wp config create --dbname=wordpress --dbuser=$LOGIN --dbpass=$PASSWORD --dbhost=mariadb --dbcharset="utf8mb4" --dbcollate="utf8mb4_unicode_ci" --force --allow-root

# Installation en utilisant la config par defaut cree precedemment
	wp core install --url=$DOMAIN_NAME --title=inception --admin_user=$LOGIN --admin_password=$PASSWORD --admin_email=$EMAIL --skip-email --allow-root

	echo "WP CORE INSTALL DONE\n"
# Creation de guest
#	--allow_root: changement en utilisant les permissions roots
	wp user create $GUEST_LOGIN $GUEST_EMAIL --user_pass=$GUEST_PASSWORD --allow-root

# Modification du cgi.pathinfo
#	on change le 1 en 0, afin que le cgi puisse attendre une requete du NGINX
	sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.3/fpm/php.ini;
	touch .installed
fi

echo "Wordpress setup done!"

# Execution du script
#	Evite davoir deux commandes exec en meme temps
#	important pour la prise en charge des signaux en cas de SIGTERM
exec "$@"
