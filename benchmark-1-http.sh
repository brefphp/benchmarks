#!/usr/bin/env bash

set -e

for value in {1..1200}
do
    # HTTP application
    curl --silent https://6vx096tc91.execute-api.us-east-2.amazonaws.com/128 > /dev/null &
    curl --silent https://6vx096tc91.execute-api.us-east-2.amazonaws.com/512 > /dev/null &
    curl --silent https://6vx096tc91.execute-api.us-east-2.amazonaws.com/1024 > /dev/null &
    curl --silent https://6vx096tc91.execute-api.us-east-2.amazonaws.com/1769 > /dev/null &
    # Laravel
    curl --silent https://vymepouxc5.execute-api.us-east-2.amazonaws.com/1024 > /dev/null &
    wait
    sleep 1
done
