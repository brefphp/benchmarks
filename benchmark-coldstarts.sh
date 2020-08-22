#!/usr/bin/env bash

set -e

# Before running this script make sure the lambdas were deployed (to ensure we get cold starts)

# Launch many invocations in parallel to trigger as many cold starts as possible

for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-128 /dev/null &
done
wait # Wait for all invocations to finish
for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-512 /dev/null &
done
wait # Wait for all invocations to finish
for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-1024 /dev/null &
done
wait # Wait for all invocations to finish
for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-1792 /dev/null &
done
wait # Wait for all invocations to finish
for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-2048 /dev/null &
done
wait # Wait for all invocations to finish
for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-3000 /dev/null &
done
wait # Wait for all invocations to finish

# HTTP application
ab -c 20 -n 20 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/128
ab -c 20 -n 20 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/512
ab -c 20 -n 20 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/1024
ab -c 20 -n 20 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/1792
ab -c 20 -n 20 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/2048
ab -c 20 -n 20 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/3000

# Symfony
ab -c 20 -n 20 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/128
ab -c 20 -n 20 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/512
ab -c 20 -n 20 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/1024
ab -c 20 -n 20 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/1792
ab -c 20 -n 20 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/2048
ab -c 20 -n 20 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/3000
