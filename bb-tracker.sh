#!/bin/bash

NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

mkdir /tmp/bb-tracker/ 2> /dev/null
mkdir /tmp/bb-tracker/calls/ 2> /dev/null
mkdir /tmp/bb-tracker/json/ 2> /dev/null
mkdir /tmp/bb-tracker/txt/ 2> /dev/null
mkdir ~/.config/bb-tracker/ 2> /dev/null
touch /tmp/bb-tracker/log.txt
log_timestamp=$(date "+%D  %I:%M:%S %p")

printf "\033]0;%s\a" "BB Tracker"
echo -e ${YELLOW}⢠⣤⣤⠀⠀⠀⠀⠀⠀⣤⣤⡄${NC}⠀⠀⠀⠀⠀⢰⣶⣶⣶⣶⣶⣶⣶⣶⣶⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⣶⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀${RED}⠀⠀⣠⣴⣶⣶⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣶⣶⣶⣄⠀⠀⠀${NC}
echo -e ${YELLOW}⢸⣿⣿⠀⠀⠀⠀⠀⠀⣿⣿⡇${NC}⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀${RED}⠀⣾⣿⣿⠿⠿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⡿⠿⣿⣿⣧⠀⠀${NC}
echo -e ${YELLOW}⢸⣿⣿⠀⠀⠀⠀⠀⠀⣿⣿⡇${NC}⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠀⠀⠀⢀⣀⣀⠀⣠⣄⠀⠀⢀⣠⣤⣄⣀⠀⠀⠀⠀⠀⢀⣠⣤⣄⡀⠀⠀⠀⣿⣿⡇⠀⠀⢀⣀⣀⡀⠀⠀⣀⣤⣤⣀⠀⠀⠀⠀⣀⣀⡀⣀⣤⠀${RED}⢸⣿⣿⠁⠀⠀⠘⣿⣿⡇⠀⠀⠀⠀⠀⢰⣿⣿⠏⠀⠀⠘⣿⣿⣇⠀${NC}
echo -e ${YELLOW}⢸⣿⣿⣶⣶⣶⣦⣄⠀⣿⣿⣷⣶⣶⣶⣦⡀${NC}⠀⠀⠀⠀⣿⣿⣿⠀⠀⠀⢸⣿⣿⣾⣿⣿⠀⣴⣿⣿⣿⣿⣿⣷⡀⠀⠀⣴⣿⣿⣿⣿⣿⣦⠀⠀⣿⣿⡇⠀⢠⣿⣿⠟⠀⢀⣾⣿⣿⣿⣿⣷⡄⠀⠀⣿⣿⣷⣿⣿⠀${RED}⠈⠉⠉⠀⠀⠀⢠⣿⣿⠇⠀⠀⠀⠀⠀⣾⣿⣿⠀⠀⠀⠀⢹⣿⣿⠀${NC}
echo -e ${YELLOW}⢸⣿⣿⣿⣿⣿⣿⣿⡆⣿⣿⣿⣿⣿⣿⣿⣿${NC}⠀⠀⠀⠀⣿⣿⣿⠀⠀⠀⢸⣿⣿⠟⠉⠉⠠⠿⠿⠋⠀⠈⣿⣿⡇⠀⣸⣿⣿⠋⠀⠙⣿⣿⡇⠀⣿⣿⡇⢠⣿⣿⠏⠀⠀⣾⣿⡟⠁⠀⠹⣿⣿⡀⠀⣿⣿⡿⠋⠉⠀${RED}⠀⠀⠀⠀⠀⢠⣾⣿⡟⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⢸⣿⣿⠀${NC}
echo -e ${YELLOW}⠀⠀⠀⠀⠀⠈⢻⣿⣷⠀⠀⠀⠀⠀⠙⣿⣿⡇${NC}⠀⠀⠀⣿⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⠀⢀⣠⣤⣤⣤⣿⣿⡇⠀⣿⣿⡏⠀⠀⠀⠈⠉⠁⠀⣿⣿⣷⣿⣿⡃⠀⠀⢰⣿⣿⣦⣤⣤⣤⣿⣿⡇⠀⣿⣿⡇⠀⠀⠀${RED}⠀⠀⠀⠀⣰⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⣿⣿⣇⠀⠀⠀⠀⢸⣿⣿⠀${NC}
echo -e ${YELLOW}⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⣿⣿⡇${NC}⠀⠀⠀⣿⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⢠⣿⣿⡿⠿⠛⣿⣿⡇⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣷⠀⠀⢸⣿⣿⠟⠛⠛⠛⠛⠛⠃⠀⣿⣿⡇⠀⠀⠀${RED}⠀⠀⢀⣾⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⠀⠀⠀⠀⣸⣿⣿⠀${NC}
echo -e ${YELLOW}⢀⣤⣤⣤⣤⣤⣿⣿⡟⣠⣤⣤⣤⣤⣼⣿⣿⠇${NC}⠀⠀⠀⣿⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⢀⣿⣿⡇⠀⢻⣿⣷⡀⠀⠀⣾⣿⡇⠀⣿⣿⡏⠘⣿⣿⣧⠀⠀⣿⣿⣇⠀⠀⠀⣤⣤⡄⠀⣿⣿⡇⠀⠀⠀${RED}⠀⣠⣿⣿⠟⠀⠀⠀⠀⠀⠀⢀⣄⡀⠀⠸⣿⣿⣆⠀⠀⢠⣿⣿⡏⠀${NC}
echo -e ${YELLOW}⢸⣿⣿⣿⣿⣿⣿⣿⠇⣿⣿⣿⣿⣿⣿⣿⡿${NC}⠀⠀⠀⠀⣿⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⠸⣿⣿⣶⣶⣿⣿⣿⡇⠀⠈⢿⣿⣿⣶⣾⣿⡿⠁⠀⣿⣿⡇⠀⠘⣿⣿⣧⠀⠹⣿⣿⣶⣶⣾⣿⡟⠀⠀⣿⣿⡇⠀⠀⠀${RED}⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⣿⣿⣷⠀⠀⠹⣿⣿⣷⣾⣿⣿⡟⠀⠀${NC}
echo -e ${YELLOW}⠘⠛⠛⠛⠛⠛⠛⠉⠀⠛⠛⠛⠛⠛⠛⠋⠁${NC}⠀⠀⠀⠀⠛⠛⠛⠀⠀⠀⠘⠛⠛⠀⠀⠀⠀⠙⠻⠿⠛⠁⠛⠛⠃⠀⠀⠀⠙⠻⠿⠟⠋⠀⠀⠀⠛⠛⠃⠀⠀⠘⠛⠛⠃⠀⠈⠛⠿⠿⠟⠋⠀⠀⠀⠛⠛⠃⠀⠀⠀${RED}⠘⠛⠛⠛⠛⠛⠛⠛⠛⠃⠀⠙⠿⠃⠀⠀⠀⠈⠛⠿⠿⠟⠋⠀${NC}

api_key_setup () {
rm ~/.config/bb-tracker/.env 2> /dev/null & rm ~/.config/bb-tracker/username.txt 2> /dev/null & rm ~/.config/bb-tracker/account-id.txt 2> /dev/null & rm /tmp/bb-tracker/calls/login.sh 2> /dev/null

echo -e "${RED}Configuration missing or incorrect..${NC}"

prompt="Enter BB api key: "
bb_api_key=""

stty -echo

printf "$prompt"

while IFS= read -r -s -n1 char; do
  if [[ $char == $'\0' ]]; then
    break
  elif [[ $char == $'\177' ]]; then
    if [ ${#bb_api_key} -gt 0 ]; then
      bb_api_key="${bb_api_key%?}"
      printf "\b \b"
    fi
  else
    bb_api_key+="$char"
    printf "*"
  fi
done

stty echo
printf "\n"

touch ~/.config/bb-tracker/.env
echo $bb_api_key > ~/.config/bb-tracker/.env
echo "api_key_setup completed. - $log_timestamp" >> /tmp/bb-tracker/log.txt
account_id_setup
}

account_id_setup () {
read -p "$(echo -e ${NC}"Enter account ID: "${NC})" ACCOUNT_ID
touch ~/.config/bb-tracker/account-id.txt
echo -n "$ACCOUNT_ID" > ~/.config/bb-tracker/account-id.txt
wget -O /tmp/bb-tracker/calls/login.sh https://raw.githubusercontent.com/Sod-ers/BB-Tracker/refs/heads/main/calls/login.sh 2> /dev/null
sed -i "s/replace-id/$ACCOUNT_ID/g" /tmp/bb-tracker/calls/login.sh
bash /tmp/bb-tracker/calls/login.sh
echo "account_id_setup completed. - $log_timestamp" >> /tmp/bb-tracker/log.txt
api_key_validator
}

api_key_validator () {
if [ ! -f ~/.config/bb-tracker/.env ]; then
echo "api_key_validator failed - $log_timestamp" >> /tmp/bb-tracker/log.txt
api_key_setup
else
echo "api_key_validator passed - $log_timestamp" >> /tmp/bb-tracker/log.txt
username_validator
fi
}

blank_username_validator () {
if [ -s ~/.config/bb-tracker/username.txt ]; then
echo "blank_username_validator passed - $log_timestamp" >> /tmp/bb-tracker/log.txt
account_id_validator
else
echo "blank_username_validator failed - $log_timestamp" >> /tmp/bb-tracker/log.txt
api_key_setup
fi
}

username_validator () {
if [ ! -f ~/.config/bb-tracker/username.txt ]; then
echo "username_validator failed - $log_timestamp" >> /tmp/bb-tracker/log.txt
api_key_setup
else
echo "username_validator passed - $log_timestamp" >> /tmp/bb-tracker/log.txt
blank_username_validator
fi
}

account_id_validator () {
if [ -s ~/.config/bb-tracker/account-id.txt ]; then
echo "account_id_validator passed - $log_timestamp" >> /tmp/bb-tracker/log.txt
else
echo "account_id_validator failed - $log_timestamp" >> /tmp/bb-tracker/log.txt
api_key_setup
fi
}

api_key_validator

api_key=$(cat ~/.config/bb-tracker/.env 2>/dev/null)

platinum_check () {
ACCOUNT_ID=$(cat ~/.config/bb-tracker/account-id.txt)
wget -O /tmp/bb-tracker/calls/platinum_check.sh https://raw.githubusercontent.com/Sod-ers/BB-Tracker/refs/heads/main/calls/platinum_check.sh 2> /dev/null
sed -i "s/replace-id/$ACCOUNT_ID/g" /tmp/bb-tracker/calls/platinum_check.sh
bash /tmp/bb-tracker/calls/platinum_check.sh
}

current_map_check () {
curl -s 'https://bbservers.dev/v2/query' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: https://bbservers.dev' -H "apiKey: $api_key" --data-binary '{"query":"{\n  serverinfo {\n    name\n    queryInfo {\n      serverName\n      map\n      numPlayers\n      maxPlayers\n    }\n  }\n}"}' --compressed | jq '.' > /tmp/bb-tracker/json/current-maps-1.json
jq '.data' /tmp/bb-tracker/json/current-maps-1.json > /tmp/bb-tracker/json/current-maps-2.json
# gofish
jq '.serverinfo[] | select(.name=="gofish")' /tmp/bb-tracker/json/current-maps-2.json > /tmp/bb-tracker/json/gofish-current.json
jq -r '.queryInfo.serverName' /tmp/bb-tracker/json/gofish-current.json > /tmp/bb-tracker/txt/gofish-server-name.txt
jq -r '.queryInfo.map' /tmp/bb-tracker/json/gofish-current.json > /tmp/bb-tracker/txt/gofish-current-map.txt
jq -r '.queryInfo.numPlayers' /tmp/bb-tracker/json/gofish-current.json > /tmp/bb-tracker/txt/gofish-current-players.txt
jq -r '.queryInfo.maxPlayers' /tmp/bb-tracker/json/gofish-current.json > /tmp/bb-tracker/txt/gofish-max-players.txt
gofish_server_name=$(cat /tmp/bb-tracker/txt/gofish-server-name.txt)
gofish_current_map=$(cat /tmp/bb-tracker/txt/gofish-current-map.txt)
gofish_current_players=$(cat /tmp/bb-tracker/txt/gofish-current-players.txt)
gofish_max_players=$(cat /tmp/bb-tracker/txt/gofish-max-players.txt)
# deathrun
jq '.serverinfo[] | select(.name=="deathrun")' /tmp/bb-tracker/json/current-maps-2.json > /tmp/bb-tracker/json/deathrun-current.json
jq -r '.queryInfo.serverName' /tmp/bb-tracker/json/deathrun-current.json > /tmp/bb-tracker/txt/deathrun-server-name.txt
jq -r '.queryInfo.map' /tmp/bb-tracker/json/deathrun-current.json > /tmp/bb-tracker/txt/deathrun-current-map.txt
jq -r '.queryInfo.numPlayers' /tmp/bb-tracker/json/deathrun-current.json > /tmp/bb-tracker/txt/deathrun-current-players.txt
jq -r '.queryInfo.maxPlayers' /tmp/bb-tracker/json/deathrun-current.json > /tmp/bb-tracker/txt/deathrun-max-players.txt
deathrun_server_name=$(cat /tmp/bb-tracker/txt/deathrun-server-name.txt)
deathrun_current_map=$(cat /tmp/bb-tracker/txt/deathrun-current-map.txt)
deathrun_current_players=$(cat /tmp/bb-tracker/txt/deathrun-current-players.txt)
deathrun_max_players=$(cat /tmp/bb-tracker/txt/deathrun-max-players.txt)
# climb
jq '.serverinfo[] | select(.name=="climb")' /tmp/bb-tracker/json/current-maps-2.json > /tmp/bb-tracker/json/climb-current.json
jq -r '.queryInfo.serverName' /tmp/bb-tracker/json/climb-current.json > /tmp/bb-tracker/txt/climb-server-name.txt
jq -r '.queryInfo.map' /tmp/bb-tracker/json/climb-current.json > /tmp/bb-tracker/txt/climb-current-map.txt
jq -r '.queryInfo.numPlayers' /tmp/bb-tracker/json/climb-current.json > /tmp/bb-tracker/txt/climb-current-players.txt
jq -r '.queryInfo.maxPlayers' /tmp/bb-tracker/json/climb-current.json > /tmp/bb-tracker/txt/climb-max-players.txt
climb_server_name=$(cat /tmp/bb-tracker/txt/climb-server-name.txt)
climb_current_map=$(cat /tmp/bb-tracker/txt/climb-current-map.txt)
climb_current_players=$(cat /tmp/bb-tracker/txt/climb-current-players.txt)
climb_max_players=$(cat /tmp/bb-tracker/txt/climb-max-players.txt)
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
# surf-easy-plat
jq '.serverinfo[] | select(.name=="surf-easy-plat")' /tmp/bb-tracker/json/current-maps-2.json > /tmp/bb-tracker/json/surf-easy-plat-current.json
jq -r '.queryInfo.serverName' /tmp/bb-tracker/json/surf-easy-plat-current.json > /tmp/bb-tracker/txt/surf-easy-plat-server-name.txt
jq -r '.queryInfo.map' /tmp/bb-tracker/json/surf-easy-plat-current.json > /tmp/bb-tracker/txt/surf-easy-plat-current-map.txt
jq -r '.queryInfo.numPlayers' /tmp/bb-tracker/json/surf-easy-plat-current.json > /tmp/bb-tracker/txt/surf-easy-plat-current-players.txt
jq -r '.queryInfo.maxPlayers' /tmp/bb-tracker/json/surf-easy-plat-current.json > /tmp/bb-tracker/txt/surf-easy-plat-max-players.txt
surf_easy_plat_server_name=$(cat /tmp/bb-tracker/txt/surf-easy-plat-server-name.txt)
surf_easy_plat_current_map=$(cat /tmp/bb-tracker/txt/surf-easy-plat-current-map.txt)
surf_easy_plat_current_players=$(cat /tmp/bb-tracker/txt/surf-easy-plat-current-players.txt)
surf_easy_plat_max_players=$(cat /tmp/bb-tracker/txt/surf-easy-plat-max-players.txt)
# surf-hard-plat
jq '.serverinfo[] | select(.name=="surf-hard-plat")' /tmp/bb-tracker/json/current-maps-2.json > /tmp/bb-tracker/json/surf-hard-plat-current.json
jq -r '.queryInfo.serverName' /tmp/bb-tracker/json/surf-hard-plat-current.json > /tmp/bb-tracker/txt/surf-hard-plat-server-name.txt
jq -r '.queryInfo.map' /tmp/bb-tracker/json/surf-hard-plat-current.json > /tmp/bb-tracker/txt/surf-hard-plat-current-map.txt
jq -r '.queryInfo.numPlayers' /tmp/bb-tracker/json/surf-hard-plat-current.json > /tmp/bb-tracker/txt/surf-hard-plat-current-players.txt
jq -r '.queryInfo.maxPlayers' /tmp/bb-tracker/json/surf-hard-plat-current.json > /tmp/bb-tracker/txt/surf-hard-plat-max-players.txt
surf_hard_plat_server_name=$(cat /tmp/bb-tracker/txt/surf-hard-plat-server-name.txt)
surf_hard_plat_current_map=$(cat /tmp/bb-tracker/txt/surf-hard-plat-current-map.txt)
surf_hard_plat_current_players=$(cat /tmp/bb-tracker/txt/surf-hard-plat-current-players.txt)
surf_hard_plat_max_players=$(cat /tmp/bb-tracker/txt/surf-hard-plat-max-players.txt)
}

platinum_check
username=$(cat ~/.config/bb-tracker/username.txt)
echo -e "${YELLOW}Welcome, $username.${NC}"

export PS3=$'\033[0;33mSelect an option: \e[0m'
options=("Maps" "Check Lottery" "Check Loading Message" "Settings" "Logout" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Maps")
export PS3=$'\033[0;33mSelect an option: \e[0m'
options=("Check Current Maps" "Go Back")
select opt in "${options[@]}"
do
    case $opt in
        "Check Current Maps")
current_map_check
echo -e "${YELLOW}Current Maps:"
if grep -q true "/tmp/bb-tracker/txt/platinum_status.txt"; then
if [ -s /tmp/bb-tracker/txt/surf-easy-plat-current-map.txt ]; then
echo -e "${NC}$surf_easy_plat_server_name\n$surf_easy_plat_current_map\n($surf_easy_plat_current_players/$surf_easy_plat_max_players)"
else
echo "No map detected, hide." > /dev/null
fi
if [ -s /tmp/bb-tracker/txt/surf-hard-plat-current-map.txt ]; then
echo -e "\n${NC}$surf_hard_plat_server_name\n$surf_hard_plat_current_map\n($surf_hard_plat_current_players/$surf_hard_plat_max_players)\n"
else
echo "No map detected, hide." > /dev/null
fi
else
echo " " > /dev/null
fi
if [ -s /tmp/bb-tracker/txt/surf-easy-current-map.txt ]; then
echo -e "${NC}$surf_easy_server_name\n$surf_easy_current_map\n($surf_easy_current_players/$surf_easy_max_players)"
else
echo "No map detected, hide." > /dev/null
fi
if [ -s /tmp/bb-tracker/txt/surf-hard-current-map.txt ]; then
echo -e "\n${NC}$surf_hard_server_name\n$surf_hard_current_map\n($surf_hard_current_players/$surf_hard_max_players)"
else
echo "No map detected, hide." > /dev/null
fi
if [ -s /tmp/bb-tracker/txt/climb-current-map.txt ]; then
echo -e "\n${NC}$climb_server_name\n$climb_current_map\n($climb_current_players/$climb_max_players)"
else
echo "No map detected, hide." > /dev/null
fi
if [ -s /tmp/bb-tracker/txt/gofish-current-map.txt ]; then
echo -e "\n${NC}$gofish_server_name\n$gofish_current_map\n($gofish_current_players/$gofish_max_players)"
else
echo "No map detected, hide." > /dev/null
fi
if [ -s /tmp/bb-tracker/txt/deathrun-current-map.txt ]; then
echo -e "\n${NC}$deathrun_server_name\n$deathrun_current_map\n($deathrun_current_players/$deathrun_max_players)"
else
echo "No map detected, hide."
fi
echo -e "${RED}Press any key to proceed.${NC}"
while true; do
read -rsn1 key
if [[ -n "$key" ]]; then
bash /tmp/bb-tracker.sh
break
fi
done
            break
            ;;
        "Go Back")
bash /tmp/bb-tracker.sh
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
            break
            ;;
        "Check Lottery")
curl -s 'https://bbservers.dev/v2/query' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: https://bbservers.dev' -H "apiKey: $api_key" --data-binary '{"query":"query{\n\t\tmiscdata { \n      lottery\n    }\n    }"}' --compressed | jq '.' > /tmp/bb-tracker/json/lottery-raw.json
touch /tmp/bb-tracker/txt/lottery-refined.txt
jq -r .data.miscdata.lottery /tmp/bb-tracker/json/lottery-raw.json > /tmp/bb-tracker/txt/lottery-refined.txt
current_lottery=$(cat /tmp/bb-tracker/txt/lottery-refined.txt)
echo -e "${YELLOW}Current pot:${NC} ${NC}$current_lottery${NC}"
echo -e "${RED}Press any key to proceed.${NC}"
while true; do
read -rsn1 key
if [[ -n "$key" ]]; then
bash /tmp/bb-tracker.sh
break
fi
done
            break
            ;;
        "Check Loading Message")
curl -s 'https://bbservers.dev/v2/query' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: https://bbservers.dev' -H "apiKey: $api_key" --data-binary '{"query":"query{\n\t\tmiscdata { \n      loadingTagLine\n    }\n    }"}' --compressed | jq '.' > /tmp/bb-tracker/json/loading-message-raw-1.json
jq -r .data.miscdata.loadingTagLine /tmp/bb-tracker/json/loading-message-raw-1.json | jq '.' > /tmp/bb-tracker/json/loading-message-raw-2.json
jq -r .user /tmp/bb-tracker/json/loading-message-raw-2.json > /tmp/bb-tracker/txt/loading-message-user-refined.txt
jq -r .userID /tmp/bb-tracker/json/loading-message-raw-2.json > /tmp/bb-tracker/txt/loading-message-user-id-refined.txt
jq -r .tagline /tmp/bb-tracker/json/loading-message-raw-2.json > /tmp/bb-tracker/txt/loading-message-refined.txt
loading_message_user_id=$(cat /tmp/bb-tracker/txt/loading-message-user-id-refined.txt)
loading_message_user=$(cat /tmp/bb-tracker/txt/loading-message-user-refined.txt)
current_loading_message=$(cat /tmp/bb-tracker/txt/loading-message-refined.txt)
echo -e "\n${YELLOW}Current loading message:${NC}\n${NC}$current_loading_message${NC}\n"
echo -e "${YELLOW}By:\n${NC}${NC}$loading_message_user${NC} ${YELLOW}($loading_message_user_id)${NC}\n"
echo -e "${RED}Press any key to proceed.${NC}"
while true; do
read -rsn1 key
if [[ -n "$key" ]]; then
bash /tmp/bb-tracker.sh
break
fi
done
            break
            ;;
        "Settings")
export PS3=$'\033[0;33mSelect an option: \e[0m'
options=("Toggle Printer" "Go Back")
select opt in "${options[@]}"
do
    case $opt in
        "Toggle Printer")
if [ ! -f ~/.local/bin/bb-tracker-printer.sh ]; then
echo -e "${RED}Thermal printer not connected. Visit BB-Tracker on GitHub for instructions.${NC}" && sleep 3
bash /tmp/bb-tracker.sh
else
export PS3=$'\033[0;33mSelect an option: \e[0m'
options=("Enable" "Disable" "Go Back")
select opt in "${options[@]}"
do
    case $opt in
        "Enable")
chmod +x ~/.local/bin/bb-tracker-printer.sh
echo -e "${GREEN}Enabled.${NC}" && sleep 1
bash /tmp/bb-tracker.sh
            break
            ;;
        "Disable")
chmod -x ~/.local/bin/bb-tracker-printer.sh
echo -e "${RED}Disabled.${NC}" && sleep 1
bash /tmp/bb-tracker.sh
            break
            ;;
        "Go Back")
bash /tmp/bb-tracker.sh
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
fi
            break
            ;;
        "Go Back")
bash /tmp/bb-tracker.sh
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
            break
            ;;
        "Logout")
rm -r ~/.config/bb-tracker/ 2> /dev/null
rm -r /tmp/bb-tracker/ 2> /dev/null
rm /tmp/bb-tracker.sh 2> /dev/null
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
