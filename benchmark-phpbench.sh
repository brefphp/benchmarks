#!/usr/bin/env bash

set -e

# PHP bench
for value in {1..50}
do
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-bench-128 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-bench-512 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-bench-1024 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-bench-1792 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-bench-2048 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-bench-3000 /dev/null > /dev/null &
    wait
done
