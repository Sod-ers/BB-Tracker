#!/bin/bash

source ~/BB-Tracker/.env

mkdir /tmp/BB-Tracker/

# Get fresh data
curl 'https://bbservers.dev/v2/query' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: https://bbservers.dev' -H 'apiKey: xxx' --data-binary '{"query":"{\n  serverinfo {\n    name\n    queryInfo{\n      map\n    }\n  }\n}"}' --compressed -o /tmp/BB-Tracker/Fresh-Data.txt

# Get time data was aquired
date "+%I:%M:%S %p  %D" > /tmp/BB-Tracker/Time.txt

# Parse data to only surf maps
grep -o 'surf_[^"]*' /tmp/BB-Tracker/Fresh-Data.txt > /tmp/BB-Tracker/Active-Maps.txt

# Copy to temp data
cp /tmp/BB-Tracker/Active-Maps.txt /tmp/BB-Tracker/Active-Server-Data-Temp.txt
