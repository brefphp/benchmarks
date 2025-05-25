#!/usr/bin/env bash

set -e

# PHP functions
for value in {1..500}
do
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref2-bench-function-dev-128 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref2-bench-function-dev-512 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref2-bench-function-dev-1024 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref2-bench-function-dev-1769 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref2-bench-function-dev-1024-container /dev/null > /dev/null &
    wait

    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref2-bench-function-dev-128-arm /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref2-bench-function-dev-512-arm /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref2-bench-function-dev-1024-arm /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref2-bench-function-dev-1769-arm /dev/null > /dev/null &
    wait

    sleep 1
done
