#!/bin/bash

echo "Injecting chaos"

docker kill myapp

sleep 10

STATUS=$(curl -s -o /dev/null \
-w "%{http_code}" \
http://localhost:5000/health)


if [ "$STATUS" != "200" ]
then

echo "Failure detected"

COUNT=$(cat logs/failurecount.txt)

COUNT=$((COUNT+1))

echo $COUNT \
> logs/failurecount.txt


./scripts/decision_engine.sh

fi