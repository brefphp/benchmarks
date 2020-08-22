http-application:
	cp -a . $(ARTIFACTS_DIR)
	cd $(ARTIFACTS_DIR) \
	&& composer install --no-dev --no-scripts --no-autoloader \
	&& composer dump-autoload --no-dev --classmap-authoritative --optimize
.PHONY: http-application

build-HttpApplication128: http-application
build-HttpApplication512: http-application
build-HttpApplication1024: http-application
build-HttpApplication1792: http-application
build-HttpApplication2048: http-application
build-HttpApplication3000: http-application
