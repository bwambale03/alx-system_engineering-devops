#!/bin/bash

API_KEY="e4694892be3b8e18d568e73a0f58d513"
APP_KEY="2d5db44679fa983aacb67c3a5cf09bd1fc74303d"
HOST_NAME="metasplt"

# Validate API and Application keys
echo "Validating API and Application keys..."
VALIDATE_RESPONSE=$(curl -s -X GET "https://api.datadoghq.com/api/v1/validate" \
-H "DD-API-KEY: $API_KEY" \
-H "DD-APPLICATION-KEY: $APP_KEY")

if [[ $VALIDATE_RESPONSE == *'"valid":true'* ]]; then
    echo "API and Application keys are valid."
else
    echo "Invalid API or Application key. Exiting."
    exit 1
fi

# Check if the server is reporting metrics
echo "Checking if the server is reporting metrics..."
METRICS_RESPONSE=$(curl -s -X GET "https://api.datadoghq.com/api/v1/metrics" \
-H "DD-API-KEY: $API_KEY" \
-H "DD-APPLICATION-KEY: $APP_KEY")

if [[ $METRICS_RESPONSE == *"$HOST_NAME"* ]]; then
    echo "Metrics are being reported by $HOST_NAME."
else
    echo "No metrics reported by $HOST_NAME. Check the Datadog agent on your server."
    exit 1
fi

# Check if the server is listed in the hosts
echo "Checking if the server is listed in Datadog hosts..."
HOSTS_RESPONSE=$(curl -s -X GET "https://api.datadoghq.com/api/v1/hosts" \
-H "DD-API-KEY: $API_KEY" \
-H "DD-APPLICATION-KEY: $APP_KEY")

if [[ $HOSTS_RESPONSE == *"$HOST_NAME"* ]]; then
    echo "$HOST_NAME is listed in Datadog hosts."
else
    echo "$HOST_NAME is not listed in Datadog hosts. Check the Datadog agent on your server."
    exit 1
fi

echo "All checks passed. Your Datadog setup is working correctly."

