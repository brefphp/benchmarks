#!/usr/bin/env bash

set -e

for value in {1..1200}
do
    # HTTP application
    curl --silent https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/128 > /dev/null &
    curl --silent https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/512 > /dev/null &
    curl --silent https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/1024 > /dev/null &
    curl --silent https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/1792 > /dev/null &
    curl --silent https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/2048 > /dev/null &
    curl --silent https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/3000 > /dev/null &
    wait
    # Symfony
    curl --silent https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/128 > /dev/null &
    curl --silent https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/512 > /dev/null &
    curl --silent https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/1024 > /dev/null &
    curl --silent https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/1792 > /dev/null &
    curl --silent https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/2048 > /dev/null &
    curl --silent https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/3000 > /dev/null &
    wait
    sleep 1
done
