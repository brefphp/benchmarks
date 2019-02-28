#!/usr/bin/env bash

set -e

# Before running this script make sure the lambdas were deployed (to ensure we get cold starts)

# Launch many invocations in parallel to trigger as many cold starts as possible

for value in {1..10}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-128 /dev/null &
done
wait # Wait for all invocations to finish

for value in {1..10}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-512 /dev/null &
done
wait # Wait for all invocations to finish

for value in {1..10}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-1024 /dev/null &
done
wait # Wait for all invocations to finish

for value in {1..10}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref-benchmark-php-function-2048 /dev/null &
done
wait # Wait for all invocations to finish
