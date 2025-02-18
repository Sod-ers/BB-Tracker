#!/bin/bash

api_key=$(cat ~/.config/bb-tracker/api-key.txt)

curl -s 'https://bbservers.dev/v2/query' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: https://bbservers.dev' -H "apiKey: $api_key" --data-binary '{"query":"query{\n    playerName(account_id:replace-id) {\n        name\n    }\n}"}' --compressed | jq '.' > /tmp/bb-tracker/json/login.json

touch ~/.config/bb-tracker/username.txt
jq -r '.data.playerName.name' /tmp/bb-tracker/json/login.json > ~/.config/bb-tracker/username.txt
