#!/bin/bash

api_key=$(cat ~/.config/bb-tracker/.env 2>/dev/null)

curl -s 'https://bbservers.dev/v2/query' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: https://bbservers.dev' -H "apiKey: $api_key" --data-binary '{"query":"query{\n    player(account_id: replace-id) {\n    \t\tinventory {\n    \t\t  sharedID\n          quality\n    \t\t  bitflags\n    \t\t}\n    }\n}"}' --compressed | jq '.' > /tmp/bb-tracker/raw/inventory.json
