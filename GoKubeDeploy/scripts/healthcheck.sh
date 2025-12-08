#!/bin/bash
URL=${1:-http://localhost:8080}
STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
if [ "$STATUS" -eq 200 ]; then
    echo "App is healthy!"
else
    echo "App is down!"
fi
