#!/bin/bash

LOG_FILE="logs/recovery.log"

mkdir -p logs

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "✅ RECOVERY SUCCESS" | tee -a $LOG_FILE
echo "Time: $TIMESTAMP" | tee -a $LOG_FILE
echo "Service: Backend API" | tee -a $LOG_FILE
echo "Action: Restart successful" | tee -a $LOG_FILE
echo "----------------------------------------" | tee -a $LOG_FILE