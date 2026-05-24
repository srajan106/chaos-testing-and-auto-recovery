#!/bin/sh

echo "Starting backend service..."

# Wait for container dependencies (optional)
sleep 3

# Log startup
echo "App started at $(date)" >> logs/start.log

# Run production server
exec gunicorn -w 4 -b 0.0.0.0:5000 app:app