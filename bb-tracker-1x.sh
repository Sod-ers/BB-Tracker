#!/bin/bash

source ~/.config/bb-tracker-printer/.env

mkdir /tmp/bb-tracker/ 2> /dev/null
mkdir /tmp/bb-tracker/json/ 2> /dev/null
mkdir /tmp/bb-tracker/txt/ 2> /dev/null
touch /tmp/bb-tracker/log.txt

log_timestamp=$(date "+%D  %I:%M:%S %p")
api_key=$(cat ~/.config/bb-tracker/.env 2>/dev/null)
time=$(date "+%I:%M:%S %p  %D")

surf_easy_favorite_maps_emailing () {
if grep -q -e surf_utopia_njv /tmp/bb-tracker/txt/surf-easy-current-map.txt
then
echo "Current Map:
$surf_easy_current_map ($surf_easy_current_players/$surf_easy_max_players)" | mail -s "Favorite Map Detected" $email_address
else
echo "Favorite maps not detected, do not email"
fi
}

surf_hard_favorite_maps_emailing () {
if grep -q -e surf_loves_spliff /tmp/bb-tracker/txt/surf-hard-current-map.txt
then
echo "Current Map:
$surf_hard_current_map ($surf_hard_current_players/$surf_hard_max_players)" | mail -s "Favorite Map Detected" $email_address
else
echo "Favorite maps not detected, do not email"
fi
}

surf_easy_map_change_validator () {
if [ ! -f /tmp/bb-tracker/txt/surf-easy-map-change-detected.txt ]; then
echo "No easy map change detected, checking hard server"
else
cat /tmp/bb-tracker/txt/printer-status.txt >> /dev/usb/lp0
cat /tmp/bb-tracker/txt/printer-status.txt >> /dev/usb/lp1
cat /tmp/bb-tracker/txt/printer-status.txt >> /dev/usb/lp2
lpr -o fit-to-page -o media=Custom.70x25mm -P EPSON_TM-T20II ~/.config/bb-tracker-printer/QR.jpg
sleep 5
lprm
exit 1
fi
}

surf_hard_map_change_validator () {
if [ ! -f /tmp/bb-tracker/txt/surf-hard-map-change-detected.txt ]; then
echo "No hard map change detected, do nothing"
else
cat /tmp/bb-tracker/txt/printer-status.txt >> /dev/usb/lp0
cat /tmp/bb-tracker/txt/printer-status.txt >> /dev/usb/lp1
cat /tmp/bb-tracker/txt/printer-status.txt >> /dev/usb/lp2
lpr -o fit-to-page -o media=Custom.70x25mm -P EPSON_TM-T20II ~/.config/bb-tracker-printer/QR.jpg
sleep 5
lprm
exit 1
fi
}

current_map_check () {
curl -s 'https://bbservers.dev/v2/query' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: https://bbservers.dev' -H "apiKey: $api_key" --data-binary '{"query":"{\n  serverinfo {\n    name\n    queryInfo {\n      serverName\n      map\n      numPlayers\n      maxPlayers\n      votemapStartsAt\n    }\n  }\n}"}' --compressed | jq '.' > /tmp/bb-tracker/json/current-maps-1.json
jq '.data' /tmp/bb-tracker/json/current-maps-1.json > /tmp/bb-tracker/json/current-maps-2.json
# surf-hard
jq '.serverinfo[] | select(.name=="surf-hard")' /tmp/bb-tracker/json/current-maps-2.json > /tmp/bb-tracker/json/surf-hard-current.json
jq -r '.queryInfo.serverName' /tmp/bb-tracker/json/surf-hard-current.json > /tmp/bb-tracker/txt/surf-hard-server-name.txt
jq -r '.queryInfo.map' /tmp/bb-tracker/json/surf-hard-current.json > /tmp/bb-tracker/txt/surf-hard-current-map.txt
jq -r '.queryInfo.numPlayers' /tmp/bb-tracker/json/surf-hard-current.json > /tmp/bb-tracker/txt/surf-hard-current-players.txt
jq -r '.queryInfo.maxPlayers' /tmp/bb-tracker/json/surf-hard-current.json > /tmp/bb-tracker/txt/surf-hard-max-players.txt
jq -r '.queryInfo.votemapStartsAt' /tmp/bb-tracker/json/surf-hard-current.json > /tmp/bb-tracker/txt/surf-hard-timestamp.txt
surf_hard_server_name=$(cat /tmp/bb-tracker/txt/surf-hard-server-name.txt)
surf_hard_current_map=$(cat /tmp/bb-tracker/txt/surf-hard-current-map.txt)
surf_hard_current_players=$(cat /tmp/bb-tracker/txt/surf-hard-current-players.txt)
surf_hard_max_players=$(cat /tmp/bb-tracker/txt/surf-hard-max-players.txt)
surf_hard_timestamp=$(cat /tmp/bb-tracker/txt/surf-hard-timestamp.txt)
# surf-easy
jq '.serverinfo[] | select(.name=="surf")' /tmp/bb-tracker/json/current-maps-2.json > /tmp/bb-tracker/json/surf-easy-current.json
jq -r '.queryInfo.serverName' /tmp/bb-tracker/json/surf-easy-current.json > /tmp/bb-tracker/txt/surf-easy-server-name.txt
jq -r '.queryInfo.map' /tmp/bb-tracker/json/surf-easy-current.json > /tmp/bb-tracker/txt/surf-easy-current-map.txt
jq -r '.queryInfo.numPlayers' /tmp/bb-tracker/json/surf-easy-current.json > /tmp/bb-tracker/txt/surf-easy-current-players.txt
jq -r '.queryInfo.maxPlayers' /tmp/bb-tracker/json/surf-easy-current.json > /tmp/bb-tracker/txt/surf-easy-max-players.txt
jq -r '.queryInfo.votemapStartsAt' /tmp/bb-tracker/json/surf-easy-current.json > /tmp/bb-tracker/txt/surf-easy-timestamp.txt
surf_easy_server_name=$(cat /tmp/bb-tracker/txt/surf-easy-server-name.txt)
surf_easy_current_map=$(cat /tmp/bb-tracker/txt/surf-easy-current-map.txt)
surf_easy_current_players=$(cat /tmp/bb-tracker/txt/surf-easy-current-players.txt)
surf_easy_max_players=$(cat /tmp/bb-tracker/txt/surf-easy-max-players.txt)
surf_easy_timestamp=$(cat /tmp/bb-tracker/txt/surf-easy-timestamp.txt)
}
current_map_check

if [ -s /tmp/bb-tracker/txt/surf-easy-current-map.txt ]; then
echo "Not empty, continue"
else
exit 1
fi

if [ -s /tmp/bb-tracker/txt/surf-hard-current-map.txt ]; then
echo "Not empty, continue"
else
exit 1
fi

echo "Manual check" > /tmp/bb-tracker/txt/surf-easy-last-known-map.txt

diff --brief <(sort /tmp/bb-tracker/txt/surf-easy-current-map.txt) <(sort /tmp/bb-tracker/txt/surf-easy-last-known-map.txt) >/dev/null
comp_value=$?
if [ $comp_value -eq 1 ]
then
# surf_easy_favorite_maps_emailing

current_timestamp=$(date +%s)
difference=$((current_timestamp - surf_easy_timestamp))
echo "$(($difference / 60 * -1))m" > /tmp/bb-tracker/txt/surf-easy-time-left.txt
surf_easy_time_left=$(cat /tmp/bb-tracker/txt/surf-easy-time-left.txt)

current_timestamp=$(date +%s)
difference=$((current_timestamp - surf_hard_timestamp))
echo "$(($difference / 60 * -1))m" > /tmp/bb-tracker/txt/surf-hard-time-left.txt
surf_hard_time_left=$(cat /tmp/bb-tracker/txt/surf-hard-time-left.txt)

cp /tmp/bb-tracker/txt/surf-easy-current-map.txt /tmp/bb-tracker/txt/surf-easy-last-known-map.txt
cp /tmp/bb-tracker/txt/surf-hard-current-map.txt /tmp/bb-tracker/txt/surf-hard-last-known-map.txt
echo "Current Maps:" > /tmp/bb-tracker/txt/printer-status.txt
echo -e "$surf_easy_current_map ($surf_easy_current_players/$surf_easy_max_players) ($surf_easy_time_left)" >> /tmp/bb-tracker/txt/printer-status.txt
echo -e "$surf_hard_current_map ($surf_hard_current_players/$surf_hard_max_players) ($surf_hard_time_left)" >> /tmp/bb-tracker/txt/printer-status.txt
echo $time >> /tmp/bb-tracker/txt/printer-status.txt
touch /tmp/bb-tracker/txt/surf-easy-map-change-detected.txt
else
rm /tmp/bb-tracker/txt/surf-easy-map-change-detected.txt
fi

diff --brief <(sort /tmp/bb-tracker/txt/surf-hard-current-map.txt) <(sort /tmp/bb-tracker/txt/surf-hard-last-known-map.txt) >/dev/null
comp_value=$?
if [ $comp_value -eq 1 ]
then
# surf_hard_favorite_maps_emailing

current_timestamp=$(date +%s)
difference=$((current_timestamp - surf_easy_timestamp))
echo "$(($difference / 60 * -1))m" > /tmp/bb-tracker/txt/surf-easy-time-left.txt
surf_easy_time_left=$(cat /tmp/bb-tracker/txt/surf-easy-time-left.txt)

current_timestamp=$(date +%s)
difference=$((current_timestamp - surf_hard_timestamp))
echo "$(($difference / 60 * -1))m" > /tmp/bb-tracker/txt/surf-hard-time-left.txt
surf_hard_time_left=$(cat /tmp/bb-tracker/txt/surf-hard-time-left.txt)

cp /tmp/bb-tracker/txt/surf-hard-current-map.txt /tmp/bb-tracker/txt/surf-hard-last-known-map.txt
cp /tmp/bb-tracker/txt/surf-easy-current-map.txt /tmp/bb-tracker/txt/surf-easy-last-known-map.txt
echo -e "Current Maps:" > /tmp/bb-tracker/txt/printer-status.txt
echo -e "$surf_easy_current_map ($surf_easy_current_players/$surf_easy_max_players) ($surf_easy_time_left)" >> /tmp/bb-tracker/txt/printer-status.txt
echo -e "$surf_hard_current_map ($surf_hard_current_players/$surf_hard_max_players) ($surf_hard_time_left)" >> /tmp/bb-tracker/txt/printer-status.txt
echo $time >> /tmp/bb-tracker/txt/printer-status.txt
touch /tmp/bb-tracker/txt/surf-hard-map-change-detected.txt
else
rm /tmp/bb-tracker/txt/surf-hard-map-change-detected.txt
fi

surf_easy_map_change_validator
# surf_hard_map_change_validator
