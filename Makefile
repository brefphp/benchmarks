# Deploy all the lambdas
deploy:
	cd bref-1 && serverless deploy && serverless info
	cd bref-2 && serverless deploy && serverless info

bench-cold-starts-1:
	./benchmark-1-coldstarts.sh
bench-function-1:
	./benchmark-1-function.sh
bench-http-1:
	./benchmark-1-http.sh

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
	cd bref-1/function && composer update --no-dev --classmap-authoritative
	cd bref-1/fpm && composer update --no-dev --classmap-authoritative
	cd bref-1/laravel && composer update --no-dev --classmap-authoritative && php artisan config:clear && php artisan route:cache
	cd bref-2/function && composer update --no-dev --classmap-authoritative
	cd bref-2/fpm && composer update --no-dev --classmap-authoritative
	cd bref-2/laravel && composer update --no-dev --classmap-authoritative && php artisan config:clear && php artisan route:cache

.PHONY: setup
