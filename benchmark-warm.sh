#!/usr/bin/env bash

set -e

for value in {1..100}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-128 /dev/null > /dev/null &
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-512 /dev/null > /dev/null &
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-1024 /dev/null > /dev/null &
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-2048 /dev/null > /dev/null &
    wait
done
