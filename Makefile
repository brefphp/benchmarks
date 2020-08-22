# Deploy all the lambdas
deploy: build package
	cd .aws-sam/build \
	&& sam deploy \
        --template-file .stack.yaml \
        --stack-name bref-benchmarks \
        --capabilities CAPABILITY_IAM \
        --region us-east-2
.PHONY: deploy

build:
	sam build --template-file template.yaml
.PHONY: build

package:
	cd .aws-sam/build \
	&& sam package \
        --template-file template.yaml \
        --output-template-file .stack.yaml \
        --s3-bucket bref-benchmark
.PHONY: package

bench-cold-starts:
	./benchmark-coldstarts.sh
.PHONY: bench-cold-stack

bench-function:
	./benchmark-function.sh
.PHONY: bench-function

bench-http:
	./benchmark-http.sh
.PHONY: bench-http

bench-phpbench:
	./benchmark-phpbench.sh
.PHONY: bench-phpbench
