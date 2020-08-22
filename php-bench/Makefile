php-bench:
	cp -a . $(ARTIFACTS_DIR)
	cd $(ARTIFACTS_DIR) \
	&& composer install --no-dev --no-scripts --no-autoloader \
	&& composer dump-autoload --no-dev --classmap-authoritative --optimize
.PHONY: php-bench

build-PhpBench128: php-bench
build-PhpBench512: php-bench
build-PhpBench1024: php-bench
build-PhpBench1792: php-bench
build-PhpBench2048: php-bench
build-PhpBench3000: php-bench
