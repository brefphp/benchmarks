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

bench-cold-starts:
	./benchmark-coldstarts.sh

bench-warm: bench-function bench-http
	./benchmark-warm.sh

bench-function:
	./benchmark-function.sh

bench-http:
	./benchmark-http.sh

bench-phpbench:
	./benchmark-phpbench.sh

# Set things up
setup:
	cd php-function && composer install --no-dev --classmap-authoritative
	cd http-application && composer install --no-dev --classmap-authoritative
	cd php-bench && composer install --no-dev --classmap-authoritative
	cd symfony && composer install --no-dev --classmap-authoritative --no-scripts
	rm -rf symfony/var/cache/*
	cd symfony && php bin/console cache:clear --no-debug --env=prod

.PHONY: setup
