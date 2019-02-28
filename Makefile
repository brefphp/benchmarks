# Deploy all the lambdas
deploy: setup
	sam package \
        --template-file template.yaml \
        --output-template-file .stack.yaml \
        --s3-bucket bref-benchmarks
	sam deploy \
        --template-file .stack.yaml \
        --stack-name bref-benchmarks \
        --capabilities CAPABILITY_IAM \
        --region us-east-2
.PHONY: deploy

bench-cold-starts:
	./benchmark-coldstarts.sh

bench-warm:
	./benchmark-warm.sh

# Set things up
php_function_vendors = $(addsuffix /vendor, $(wildcard php-function-*))
php_function_index = $(addsuffix /index.php, $(wildcard php-function-*))
http_app_vendors = $(addsuffix /vendor, $(wildcard http-application-*))
http_app_index = $(addsuffix /index.php, $(wildcard http-application-*))
setup: vendor $(php_function_vendors) $(php_function_index) $(http_app_vendors) $(http_app_index)
.PHONY: setup
vendor: composer.lock
	composer install --classmap-authoritative

# Prepare the `php-function` template function
php-function/composer.lock: php-function/composer.json
	cd php-function && composer update --classmap-authoritative
# Synchronize all `php-function-*` directories
php-function-%/index.php: php-function/index.php
	cp php-function/index.php $(@D)/index.php
php-function-%/vendor: php-function/composer.json php-function/composer.lock
	cp php-function/composer.json $(@D)/composer.json
	cp php-function/composer.lock $(@D)/composer.lock
	cd $(@D) && composer install --classmap-authoritative

# Prepare the `http-application` template function
http-application/composer.lock: http-application/composer.json
	cd http-application && composer update --classmap-authoritative
# Synchronize all `http-application-*` directories
http-application-%/index.php: http-application/index.php
	cp http-application/index.php $(@D)/index.php
http-application-%/vendor: http-application/composer.json http-application/composer.lock
	cp http-application/composer.json $(@D)/composer.json
	cp http-application/composer.lock $(@D)/composer.lock
	cd $(@D) && composer install --classmap-authoritative
