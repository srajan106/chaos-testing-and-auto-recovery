#!/bin/bash

LOG_FILE="logs/rollback.log"
BACKUP_FILE="backups/previous-image.txt"

mkdir -p logs backups

echo "⏪ Rollback initiated..." | tee -a $LOG_FILE

# Check if backup exists
if [ ! -f $BACKUP_FILE ]; then
    echo "❌ No backup image found!" | tee -a $LOG_FILE
    exit 1
fi

IMAGE=$(cat $BACKUP_FILE)

echo "Using backup image: $IMAGE" | tee -a $LOG_FILE

# Stop current service
docker compose down

# Start with previous image
docker compose up -d --build

echo "✅ Rollback completed successfully" | tee -a $LOG_FILE
echo "----------------------------------------" | tee -a $LOG_FILE