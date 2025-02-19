#!/bin/bash

api_key=$(cat ~/.config/bb-tracker/api-key.txt)

curl -s 'https://bbservers.dev/v2/query' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: https://bbservers.dev' -H "apiKey: $api_key" --data-binary '{"query":"query{\n    player(account_id:replace-id) {\n    \t\tisPlatinum\n    }\n}"}' --compressed | jq '.' > /tmp/bb-tracker/json/platinum_check.json

touch /tmp/bb-tracker/txt/platinum_status.txt
jq -r '.data.player.isPlatinum' /tmp/bb-tracker/json/platinum_check.json > /tmp/bb-tracker/txt/platinum_status.txt
