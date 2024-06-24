NAME := Inception

COMPOSE := srcs/docker-compose.yml

build:
		@echo "Building $(NAME)..."
		docker-compose -f $(COMPOSE) build

up:
		@echo "Starting $(NAME)..."
		docker-compose -f $(COMPOSE) up -d

down:
		@echo "Stopping and removing Docker containers for $(NAME)..."
		docker-compose -f $(COMPOSE) down

start:
		@echo "Starting $(NAME)..."
		docker-compose -f $(COMPOSE) start

stop:
		@echo "Stopping Docker for $(NAME)..."
		docker-compose -f $(COMPOSE) stop

clean:
		@echo "Clearing the cache for $(NAME)..."
		docker system prune -a -f

re:
		rm -rf ./srcs/web
		docker-compose -f $(COMPOSE) down
		docker system prune -a -f
		docker-compose -f $(COMPOSE) up -d
logs:
		@echo "Viewing logs of Docker for $(NAME)..."
		docker-compose -f $(COMPOSE) logs

status:
		@echo "Displaying status of Docker containers for $(NAME)..."
		docker-compose -f $(COMPOSE) ps

fclean: down clean
		rm -rf ./srcs/web
	

all: build up

.PHONY : build up down start stop logs status fclean all
