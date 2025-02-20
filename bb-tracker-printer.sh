#!/bin/bash

source ~/.config/bb-tracker-printer/.env

mkdir /tmp/bb-tracker/ 2> /dev/null
mkdir /tmp/bb-tracker/json/ 2> /dev/null
mkdir /tmp/bb-tracker/txt/ 2> /dev/null
touch /tmp/bb-tracker/log.txt

log_timestamp=$(date "+%D  %I:%M:%S %p")
api_key=$(cat ~/.config/bb-tracker/api-key.txt 2>/dev/null)

echo "bb-tracker-printer.sh executed - $log_timestamp" >> /tmp/bb-tracker/log.txt

current_map_check () {
curl -s 'https://bbservers.dev/v2/query' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: https://bbservers.dev' -H "apiKey: $api_key" --data-binary '{"query":"{\n  serverinfo {\n    name\n    queryInfo {\n      serverName\n      map\n      numPlayers\n      maxPlayers\n    }\n  }\n}"}' --compressed | jq '.' > /tmp/bb-tracker/json/current-maps-1.json
jq '.data' /tmp/bb-tracker/json/current-maps-1.json > /tmp/bb-tracker/json/current-maps-2.json
# surf-hard
jq '.serverinfo[] | select(.name=="surf-hard")' /tmp/bb-tracker/json/current-maps-2.json > /tmp/bb-tracker/json/surf-hard-current.json
jq -r '.queryInfo.serverName' /tmp/bb-tracker/json/surf-hard-current.json > /tmp/bb-tracker/txt/surf-hard-server-name.txt
jq -r '.queryInfo.map' /tmp/bb-tracker/json/surf-hard-current.json > /tmp/bb-tracker/txt/surf-hard-current-map.txt
jq -r '.queryInfo.numPlayers' /tmp/bb-tracker/json/surf-hard-current.json > /tmp/bb-tracker/txt/surf-hard-current-players.txt
jq -r '.queryInfo.maxPlayers' /tmp/bb-tracker/json/surf-hard-current.json > /tmp/bb-tracker/txt/surf-hard-max-players.txt
surf_hard_server_name=$(cat /tmp/bb-tracker/txt/surf-hard-server-name.txt)
surf_hard_current_map=$(cat /tmp/bb-tracker/txt/surf-hard-current-map.txt)
surf_hard_current_players=$(cat /tmp/bb-tracker/txt/surf-hard-current-players.txt)
surf_hard_max_players=$(cat /tmp/bb-tracker/txt/surf-hard-max-players.txt)
# surf-easy
jq '.serverinfo[] | select(.name=="surf")' /tmp/bb-tracker/json/current-maps-2.json > /tmp/bb-tracker/json/surf-easy-current.json
jq -r '.queryInfo.serverName' /tmp/bb-tracker/json/surf-easy-current.json > /tmp/bb-tracker/txt/surf-easy-server-name.txt
jq -r '.queryInfo.map' /tmp/bb-tracker/json/surf-easy-current.json > /tmp/bb-tracker/txt/surf-easy-current-map.txt
jq -r '.queryInfo.numPlayers' /tmp/bb-tracker/json/surf-easy-current.json > /tmp/bb-tracker/txt/surf-easy-current-players.txt
jq -r '.queryInfo.maxPlayers' /tmp/bb-tracker/json/surf-easy-current.json > /tmp/bb-tracker/txt/surf-easy-max-players.txt
surf_easy_server_name=$(cat /tmp/bb-tracker/txt/surf-easy-server-name.txt)
surf_easy_current_map=$(cat /tmp/bb-tracker/txt/surf-easy-current-map.txt)
surf_easy_current_players=$(cat /tmp/bb-tracker/txt/surf-easy-current-players.txt)
surf_easy_max_players=$(cat /tmp/bb-tracker/txt/surf-easy-max-players.txt)
}
current_map_check

if [ -s /tmp/bb-tracker/txt/surf-hard-current-map.txt ]; then
echo "Not empty, continue"
else
exit 1
fi

if [ -s /tmp/bb-tracker/txt/surf-easy-current-map.txt ]; then
echo "Not empty, continue"
else
exit 1
fi

time=$(date "+%I:%M:%S %p  %D")

diff --brief <(sort /tmp/bb-tracker/txt/surf-easy-current-map.txt) <(sort /tmp/bb-tracker/txt/surf-easy-last-known-map.txt) >/dev/null
comp_value=$?
if [ $comp_value -eq 1 ]
then
echo "Current Maps:" > /tmp/bb-tracker/txt/printer-status.txt
echo -e "$surf_easy_current_map ($surf_easy_current_players/$surf_easy_max_players)" >> /tmp/bb-tracker/txt/printer-status.txt
echo -e "$surf_hard_current_map ($surf_hard_current_players/$surf_hard_max_players)" >> /tmp/bb-tracker/txt/printer-status.txt
echo $time >> /tmp/bb-tracker/txt/printer-status.txt
else
exit 1
fi

diff --brief <(sort /tmp/bb-tracker/txt/surf-hard-current-map.txt) <(sort /tmp/bb-tracker/txt/surf-hard-last-known-map.txt) >/dev/null
comp_value=$?
if [ $comp_value -eq 1 ]
then
echo -e "Current Maps:" > /tmp/bb-tracker/txt/printer-status.txt
echo -e "$surf_easy_current_map ($surf_easy_current_players/$surf_easy_max_players)" >> /tmp/bb-tracker/txt/printer-status.txt
echo -e "$surf_hard_current_map ($surf_hard_current_players/$surf_hard_max_players)" >> /tmp/bb-tracker/txt/printer-status.txt
echo $time >> /tmp/bb-tracker/txt/printer-status.txt
else
exit 1
fi

cp /tmp/bb-tracker/txt/surf-hard-current-map.txt /tmp/bb-tracker/txt/surf-hard-last-known-map.txt
cp /tmp/bb-tracker/txt/surf-easy-current-map.txt /tmp/bb-tracker/txt/surf-easy-last-known-map.txt

if grep -q -e surf_utopia_njv /tmp/bb-tracker/txt/surf-easy-current-map.txt /tmp/bb-tracker/txt/surf-hard-current-map.txt
then
echo "Current Maps:
$surf_easy_current_map ($surf_easy_current_players/$surf_easy_max_players)
$surf_hard_current_map ($surf_hard_current_players/$surf_hard_max_players)" | mail -s "Favorite Map Detected" $email
else
echo "Favorite maps not detected, do not email"
fi

cat /tmp/bb-tracker/txt/printer-status.txt >> /dev/usb/lp0
cat /tmp/bb-tracker/txt/printer-status.txt >> /dev/usb/lp1
cat /tmp/bb-tracker/txt/printer-status.txt >> /dev/usb/lp2
lpr -o fit-to-page -o media=Custom.70x25mm -P EPSON_TM-T20II ~/.config/bb-tracker-printer/QR.jpg
sleep 5
lprm
