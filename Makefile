NAME := inception

DOCKER_COMPOSE := docker compose

COMPOSE := srcs/docker-compose.yml

DB_VOLUME := /home/mtravez/data/database
WEB_VOLUME := /home/mtravez/data/web

all: build up
		@if [ ! -f srcs/.env ]; then
			mv /home/mtravez/resources/.env srcs/.env;

build:
		@echo "Building $(NAME)..."
		$(DOCKER_COMPOSE) -f $(COMPOSE) build

up:
		@echo "Starting $(NAME)..."
		$(DOCKER_COMPOSE) -f $(COMPOSE) up -d

down:
		@echo "Stopping and removing Docker containers for $(NAME)..."
		$(DOCKER_COMPOSE) -f $(COMPOSE) down

start:
		@echo "Starting $(NAME)..."
		$(DOCKER_COMPOSE) -f $(COMPOSE) start

stop:
		@echo "Stopping Docker for $(NAME)..."
		$(DOCKER_COMPOSE) -f $(COMPOSE) stop

clean:
		@echo "Clearing the cache for $(NAME)..."
		docker system prune -a -f

fclean: down clean
		@sudo rm -rf $(WEB_VOLUME)/*
		@sudo rm -rf $(DB_VOLUME)/*
		@docker volume rm mariadb wordpress

re: fclean
		$(DOCKER_COMPOSE) -f $(COMPOSE) up -d

logs:
		@echo "Viewing logs of Docker for $(NAME)..."
		$(DOCKER_COMPOSE) -f $(COMPOSE) logs

status:
		@echo "Displaying status of Docker containers for $(NAME)..."
		$(DOCKER_COMPOSE) -f $(COMPOSE) ps

.PHONY : build up down start stop clean fclean logs status all
