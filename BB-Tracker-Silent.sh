#!/bin/bash

source /home/soders/Programs/BB-Tracker/.env

# Get fresh data
curl 'https://bbservers.dev/v2/query' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: https://bbservers.dev' -H 'apiKey: xxx' --data-binary '{"query":"{\n  serverinfo {\n    name\n    queryInfo{\n      map\n    }\n  }\n}"}' --compressed -o ~/BB-Tracker/Fresh-Data.txt

# Get time data was aquired
date "+%I:%M:%S %p  %D" > ~/BB-Tracker/Time.txt

# Parse data to only surf maps
grep -o 'surf_[^"]*' ~/BB-Tracker/Fresh-Data.txt > ~/BB-Tracker/Active-Maps.txt

# Copy to temp data
cp ~/BB-Tracker/Active-Maps.txt ~/BB-Tracker/Active-Server-Data-Temp.txt
