build-symfony:
	cp -a . $(ARTIFACTS_DIR)
	cd $(ARTIFACTS_DIR) \
	&& composer install --no-dev --no-scripts --no-autoloader \
	&& composer dump-autoload --no-dev --classmap-authoritative --optimize \
	&& composer dump-env prod \
	&& rm .env \
	&& ./bin/console cache:warmup --env=prod
.PHONY: build-symfony

build-Symfony128: build-symfony
build-Symfony512: build-symfony
build-Symfony1024: build-symfony
build-Symfony1792: build-symfony
build-Symfony2048: build-symfony
build-Symfony3000: build-symfony
