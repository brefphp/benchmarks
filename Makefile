# Deploy all the lambdas
deploy: deploy-function deploy-fpm deploy-laravel
deploy-function:
	cd function && serverless deploy && serverless info
deploy-fpm:
	cd fpm && serverless deploy && serverless info
deploy-laravel:
	cd laravel && serverless deploy && serverless info

bench-cold-starts:
	./benchmark-coldstarts.sh
bench-function:
	./benchmark-function.sh
bench-http:
	./benchmark-http.sh

# Set things up
setup:
	cd function && composer update --no-dev --classmap-authoritative
	cd fpm && composer update --no-dev --classmap-authoritative
	cd laravel && composer update --no-dev --classmap-authoritative \
		&& php artisan config:clear \
		&& rm -f .env && cp .env.production .env \
		&& docker run --rm -it -v $$PWD:/var/task --entrypoint php bref/php-83:2 artisan optimize
	docker pull bref/php-83:2
	docker pull bref/php-83-fpm:2

.PHONY: setup
