# Deploy all the lambdas
deploy:
	cd bref-2 && serverless deploy && serverless info

bench-cold-starts-2:
	./benchmark-2-coldstarts.sh
bench-function-2:
	./benchmark-2-function.sh
bench-http-2:
	./benchmark-2-http.sh

bench-phpbench:
	./benchmark-phpbench.sh

# Set things up
setup:
	cd bref-2/function && composer update --no-dev --classmap-authoritative
	cd bref-2/fpm && composer update --no-dev --classmap-authoritative
	cd bref-2/laravel && composer update --no-dev --classmap-authoritative && php artisan config:clear && php artisan route:cache
	docker pull bref/php-83:2
	docker pull bref/php-83-fpm:2

.PHONY: setup
