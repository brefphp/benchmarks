#!/usr/bin/env bash

set -e

# Before running this script make sure the lambdas were deployed (to ensure we get cold starts)

# Launch many invocations in parallel to trigger as many cold starts as possible

for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref2-bench-function-dev-128 /dev/null &
done
wait # Wait for all invocations to finish
for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref2-bench-function-dev-512 /dev/null &
done
wait # Wait for all invocations to finish
for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref2-bench-function-dev-1024 /dev/null &
done
wait # Wait for all invocations to finish
for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref2-bench-function-dev-1769 /dev/null &
done
wait # Wait for all invocations to finish

# HTTP application
ab -c 20 -n 20 https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/128
ab -c 20 -n 20 https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/512
ab -c 20 -n 20 https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/1024
ab -c 20 -n 20 https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/1769
