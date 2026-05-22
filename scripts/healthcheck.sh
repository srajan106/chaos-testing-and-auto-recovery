#!/bin/bash

STATUS=$(curl -s \
-o /dev/null \
-w "%{http_code}" \
http://localhost:5000/health)


if [ "$STATUS" == "200" ]
then

echo "Healthy"

else

echo "Failed"

fi