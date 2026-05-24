#!/bin/bash

LOG_FILE="logs/decision.log"
FAIL_FILE="logs/failurecount.txt"

mkdir -p logs

# Initialize failure file if missing
if [ ! -f $FAIL_FILE ]; then
    echo "0" > $FAIL_FILE
fi

COUNT=$(cat $FAIL_FILE)

echo "🧠 Decision Engine Triggered" | tee -a $LOG_FILE
echo "Failure count: $COUNT" | tee -a $LOG_FILE

if [ "$COUNT" -lt 3 ]
then
    echo "🔄 Action: Restarting service" | tee -a $LOG_FILE

    docker compose restart backend

    ./scripts/logger.sh

elif [ "$COUNT" -lt 5 ]
then
    echo "⏪ Action: Rolling back system" | tee -a $LOG_FILE

    ./scripts/rollback.sh

else
    echo "🚨 Action: Sending critical alert" | tee -a $LOG_FILE

    ./scripts/alert.sh

fi

echo "--------------------------------------" | tee -a $LOG_FILE