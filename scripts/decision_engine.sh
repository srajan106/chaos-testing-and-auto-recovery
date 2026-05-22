#!/bin/bash

COUNT=$(cat logs/failurecount.txt)

if [ $COUNT -lt 3 ]
then

echo "Restart"

docker restart myapp

./scripts/logger.sh


elif [ $COUNT -lt 5 ]
then

echo "Rollback"

./scripts/rollback.sh


else

echo "Send alert"

./scripts/alert.sh

fi