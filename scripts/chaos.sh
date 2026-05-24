#!/bin/bash

LOG_FILE="logs/chaos.log"
FAIL_FILE="logs/failurecount.txt"

mkdir -p logs

echo "💥 Injecting chaos..." | tee -a $LOG_FILE
echo "$(date) - Chaos started" | tee -a $LOG_FILE

# Kill container (use docker-compose service name)
docker compose kill backend

sleep 5

# Retry health check (3 attempts)
STATUS="000"
for i in 1 2 3
do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:5000/health)
    [ "$STATUS" = "200" ] && break
    sleep 2
done

if [ "$STATUS" != "200" ]
then
    echo "❌ Failure detected" | tee -a $LOG_FILE

    # Initialize failure count if not exists
    if [ ! -f $FAIL_FILE ]; then
        echo "0" > $FAIL_FILE
    fi

    COUNT=$(cat $FAIL_FILE)
    COUNT=$((COUNT+1))
    echo $COUNT > $FAIL_FILE

    echo "Failure count: $COUNT" | tee -a $LOG_FILE

    # Trigger alert
    ./scripts/alert.sh

    # Call decision engine
    ./scripts/decision_engine.sh

else
    echo "✅ Service recovered automatically" | tee -a $LOG_FILE
fi