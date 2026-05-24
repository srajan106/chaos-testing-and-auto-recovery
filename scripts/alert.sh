#!/bin/bash

LOG_FILE="logs/incidents.log"

mkdir -p logs

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "🚨 ALERT: Critical failure detected!" | tee -a $LOG_FILE
echo "Time: $TIMESTAMP" | tee -a $LOG_FILE
echo "Service: Backend API" | tee -a $LOG_FILE
echo "Action Required: Restart or investigate immediately" | tee -a $LOG_FILE
echo "----------------------------------------" | tee -a $LOG_FILE