NAME	=	inception

DIR_MYSQL		=	/home/tthibaut/data/mariadb
DIR_WORDPRESS	=	/home/tthibaut/data/wordpress
COMPOSE_FILE	=	./srcs/docker-compose.yml
DOCKER_LIST_VOL =	"sudo docker volume ls -q"


all: run

run:
		#sudo userdel mysql
		#sudo useradd -u 999 mysql
		sudo mkdir -p ${DIR_MYSQL}
		sudo mkdir -p ${DIR_WORDPRESS}
		sudo docker compose -f ./srcs/docker-compose.yml --verbose up --build -d

clean:	clean_vol	
		sudo docker compose -f ${COMPOSE_FILE} down
		# Bon cette commande est peut etre un peu trop violente, a l'avenir, essaye
		# de cibler les images recemments crees pcq la je crois que je vire absolument tout
		sudo docker system prune -a -f --volumes

build:
		sudo docker compose -f ${CONPOSE_FILE} 	build

debug_mdb:
		sudo docker run -d mariadb tail -f /dev/null

down:
		sudo docker compose -f ${COMPOSE_FILE} down

start:
		sudo docker compose -f ${COMPOSE_FILE} start

logs:
		sudo docker compose -f ${COMPOSE_FILE} logs

run_debug:
		sudo docker compose run --build -it ${COMPOSE_FILE}

debug: clean_vol
		sudo docker compose -f ${COMPOSE_FILE} up -it

clean_vol:
#		sudo docker volume rm srcs_mariadb_data
#		sudo docker volume rm srcs_wordpress_data
		sudo rm -rf /home/tthibaut/data/mariadb
		sudo rm -rf ${DIR_WORDPRESS}



# Jarrive pas a le mettre dans le makefile, a faire a la main :
#  sudo docker volume rm $(sudo docker volume ls -q)
