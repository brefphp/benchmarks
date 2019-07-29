#!/usr/bin/env bash

set -e

# PHP functions
for value in {1..1200}
do
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-function-128 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-function-512 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-function-1024 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-function-2048 /dev/null > /dev/null &
    wait
    sleep 1
done
