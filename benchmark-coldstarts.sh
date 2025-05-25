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

for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref2-bench-function-dev-128-arm /dev/null &
done
wait # Wait for all invocations to finish
for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref2-bench-function-dev-512-arm /dev/null &
done
wait # Wait for all invocations to finish
for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref2-bench-function-dev-1024-arm /dev/null &
done
wait # Wait for all invocations to finish
for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref2-bench-function-dev-1769-arm /dev/null &
done
wait # Wait for all invocations to finish

for value in {1..20}
do
    aws lambda invoke --invocation-type Event --region us-east-2 --function-name bref2-bench-function-dev-1024-container /dev/null &
done
wait # Wait for all invocations to finish

# HTTP application
for value in {1..20}
do
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/128 > /dev/null &
done
wait
echo "."

for value in {1..20}
do
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/512 > /dev/null &
done
wait
echo "."

for value in {1..20}
do
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/1024 > /dev/null &
done
wait
echo "."

for value in {1..20}
do
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/1769 > /dev/null &
done
wait
echo "."

for value in {1..20}
do
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/128-arm > /dev/null &
done
wait
echo "."

for value in {1..20}
do
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/512-arm > /dev/null &
done
wait
echo "."

for value in {1..20}
do
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/1024-arm > /dev/null &
done
wait
echo "."

for value in {1..20}
do
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/1769-arm > /dev/null &
done
wait
echo "."

for value in {1..20}
do
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/1024-container > /dev/null &
done
wait
echo "."

# Laravel
for value in {1..20}
do
    curl --silent https://2ssqzwaiek.execute-api.us-east-2.amazonaws.com/1024 > /dev/null &
done
wait
echo "."
for value in {1..20}
do
    curl --silent https://2ssqzwaiek.execute-api.us-east-2.amazonaws.com/1024-arm > /dev/null &
done
wait
echo "."
for value in {1..20}
do
    curl --silent https://2ssqzwaiek.execute-api.us-east-2.amazonaws.com/1024-container > /dev/null &
done
wait
echo "."
