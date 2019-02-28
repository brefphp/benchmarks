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

bench-warm:
	./benchmark-warm.sh

bench-phpbench:
	./benchmark-phpbench.sh

# Set things up
setup: php-function/vendor http-application/vendor php-bench/vendor

php-function/vendor: php-function/composer.json php-function/composer.lock
	cd php-function && composer install --classmap-authoritative

http-application/vendor: http-application/composer.json http-application/composer.lock
	cd http-application && composer install --classmap-authoritative

php-bench/vendor: php-bench/composer.json php-bench/composer.lock
	cd php-bench && composer install --classmap-authoritative
