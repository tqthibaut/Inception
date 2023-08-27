# version du container
FROM	debian:buster

RUN	apt-get -o Acquire::Check-Valid-Until="false" update
RUN	apt-get install -y apt-transport-https && apt-get -y update
RUN	apt-get install -y nginx openssl

COPY	./conf/nginx.conf /etc/nginx/sites-enabled/nginx.conf

# CREATION DU DOSSIER WORDPRESS
RUN	mkdir -p /var/www/html/wordpress

# CONFIGURATION DU SECURE SOCKET LAYER
# TSL == evolution de SSL
# note: subj on peut apparemment pas tt remplir, mais cest fait au moins ici
RUN	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-out /etc/ssl/certs/nginx.crt \
	-keyout /etc/ssl/certs/nginx.key \
	-subj '/C=FR/ST=27+1/L=Le_Mordor/O=42/OU=tthibaut/CN=tthibaut.42.fr'

EXPOSE	443
# lance nginx, mais pas en mode daemon (en arriere plan). Si tu mets pas nginx en premier
# plan il sarrete automatiquement.
CMD	["/usr/sbin/nginx", "-g", "daemon off;"]
