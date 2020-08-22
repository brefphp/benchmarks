php-function:
	cp -a . $(ARTIFACTS_DIR)
	cd $(ARTIFACTS_DIR) \
	&& composer install --no-dev --no-scripts --no-autoloader \
	&& composer dump-autoload --no-dev --classmap-authoritative --optimize
.PHONY: php-function

build-PhpFunction128: php-function
build-PhpFunction512: php-function
build-PhpFunction1024: php-function
build-PhpFunction1792: php-function
build-PhpFunction2048: php-function
build-PhpFunction3000: php-function
