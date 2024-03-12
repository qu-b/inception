all: up

build:
	@docker compose -f srcs/docker-compose.yml build

up:
	@mkdir -p /home/qu-b/data/mariadb /home/qu-b/data/wordpress /home/qu-b/data/restic
	@docker compose -f srcs/docker-compose.yml up -d
	@echo "127.0.0.1 qu-b.42.fr" | sudo tee /etc/hosts

down:
	@docker compose -f srcs/docker-compose.yml down

clean:
	@docker compose -f srcs/docker-compose.yml down -v --rmi all
	@docker system prune -a --volumes -f
	@sudo rm -rf /home/qu-b/data/mariadb /home/qu-b/data/wordpress

clean-maria:
	@echo "Stopping and removing the MariaDB container..."
	@docker compose -f srcs/docker-compose.yml stop mariadb
	@docker compose -f srcs/docker-compose.yml rm -f mariadb
	@echo "Removing the MariaDB volume..."
	@docker volume rm srcs_mariadb

maria:
	@echo "Recreating the MariaDB container..."
	@docker compose -f srcs/docker-compose.yml up -d mariadb

wordpress:
	@echo "Recreating the WordPress container..."
	@docker compose -f srcs/docker-compose.yml up -d wordpress

nginx:
	@echo "Recreating the Nginx container..."
	@docker compose -f srcs/docker-compose.yml build --no-cache
	@docker compose -f srcs/docker-compose.yml up -d --force-recreate nginx

backup:
	echo "Creating backup..."
	@docker compose -f srcs/docker-compose.yml up -d restic

re: clean up

.PHONY: all build up down clean re

# docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null