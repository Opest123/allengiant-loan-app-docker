setup:
	@make build
	@make up
	# @make composer-update
build:
	docker compose build
build-no-cache:
	docker compose build --no-cache --force-rm
stop:
	docker compose stop
up:
	docker compose up -d
down:
	@make stop
destroy:
	docker compose down --rmi all --volumes --remove-orphans
ps:
	docker compose ps
dnsup:
	sudo brew services start dnsmasq
dnsdown:
	sudo brew services stop dnsmasq

clear_optimize:
	docker exec php /bin/sh -c "php artisan optimize:clear && php artisan modelCache:clear"

clear:
	@make clear_optimize

php:
	docker exec -it loan_app_php zsh
