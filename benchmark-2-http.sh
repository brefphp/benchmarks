#!/usr/bin/env bash

set -e

for value in {1..1200}
do
    # HTTP application
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/128 > /dev/null &
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/512 > /dev/null &
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/1024 > /dev/null &
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/1769 > /dev/null &
    wait

    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/128-arm > /dev/null &
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/512-arm > /dev/null &
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/1024-arm > /dev/null &
    curl --silent https://4qv4pt37t4.execute-api.us-east-2.amazonaws.com/1769-arm > /dev/null &
    wait

    sleep 1
done
