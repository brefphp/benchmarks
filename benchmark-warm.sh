#!/usr/bin/env bash

set -e

# PHP functions
for value in {1..100}
do
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-function-128 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-function-512 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-function-1024 /dev/null > /dev/null &
    aws lambda invoke --invocation-type RequestResponse --region us-east-2 --function-name bref-benchmark-php-function-2048 /dev/null > /dev/null &
    wait
done

# HTTP applications
# Warmup (to avoid cold starts)
ab -c 5 -n 5 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/128
ab -c 5 -n 5 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/512
ab -c 5 -n 5 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/1024
ab -c 5 -n 5 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/2048
# Benchmark
ab -c 5 -n 200 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/128
ab -c 5 -n 200 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/512
ab -c 5 -n 200 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/1024
ab -c 5 -n 200 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/2048
