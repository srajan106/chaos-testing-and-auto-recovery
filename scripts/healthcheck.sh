#!/bin/bash

LOG_FILE="logs/health.log"

mkdir -p logs

echo "🔍 Checking system health..." | tee -a $LOG_FILE

# Retry 3 times
STATUS="000"
for i in 1 2 3
do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:5000/health)

    if [ "$STATUS" = "200" ]; then
        break
    fi

    sleep 2
done

if [ "$STATUS" = "200" ]
then
    echo "✅ System Healthy" | tee -a $LOG_FILE
    exit 0

else
    echo "❌ System Failed" | tee -a $LOG_FILE

    # Trigger alert system
    ./scripts/alert.sh

    # Trigger decision engine (auto recovery)
    ./scripts/decision_engine.sh

    exit 1
fi