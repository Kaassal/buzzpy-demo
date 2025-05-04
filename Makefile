.PHONY: build run demo attack clean

build:
	docker-compose build

run:
	DEMO_MODE=0 LOAD_SAMPLE_DATA=0 docker-compose up -d

demo:
	DEMO_MODE=1 LOAD_SAMPLE_DATA=1 docker-compose up --force-recreate -d

attack:
	docker exec -it buzzpy-attacker bash

clean:
	docker-compose down -v --remove-orphans
	docker network prune -f
	docker volume prune -f