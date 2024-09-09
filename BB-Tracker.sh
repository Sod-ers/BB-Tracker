# Get fresh data
curl 'https://bbservers.dev/v2/query' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: https://bbservers.dev' -H 'apiKey: xxx' --data-binary '{"query":"{\n  serverinfo {\n    name\n    queryInfo{\n      map\n    }\n  }\n}"}' --compressed -o ~/BB-Tracker/Fresh-Data.txt

# Get time data was aquired
date "+%D %I:%M %p" > ~/BB-Tracker/Time.txt

# Parse data to only surf maps
grep -o 'surf_[^"]*' ~/BB-Tracker/Fresh-Data.txt > ~/BB-Tracker/Active-Maps.txt

# Compare server data
~/BB-Tracker/Compare-Server-Data.sh

# Copy to temp data
cp ~/BB-Tracker/Active-Maps.txt ~/BB-Tracker/Active-Server-Data-Temp.txt
