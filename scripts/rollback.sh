#!/bin/bash

echo "Rollback initiated"

IMAGE=$(cat backups/previous-image.txt)

docker stop myapp

docker rm myapp

docker run -d \
--name myapp \
--restart always \
-p 5000:5000 \
$IMAGE


echo "Rollback completed"