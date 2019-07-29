#!/usr/bin/env bash

set -e

# HTTP application
ab -c 5 -n 200 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/128
ab -c 5 -n 200 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/512
ab -c 5 -n 200 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/1024
ab -c 5 -n 200 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/2048

# Symfony
ab -c 5 -n 200 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/128
ab -c 5 -n 200 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/512
ab -c 5 -n 200 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/1024
ab -c 5 -n 200 https://v82j8g4a5k.execute-api.us-east-2.amazonaws.com/Prod/symfony/2048
