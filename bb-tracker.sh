#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

mkdir /tmp/bb-tracker/ 2> /dev/null
mkdir /tmp/bb-tracker/calls/ 2> /dev/null
mkdir /tmp/bb-tracker/json/ 2> /dev/null
mkdir ~/.config/bb-tracker/ 2> /dev/null
touch /tmp/bb-tracker/log.txt
log_timestamp=$(date "+%D  %I:%M:%S %p")
api_key=$(cat ~/.config/bb-tracker/api-key.txt 2>/dev/null)

username_validator () {
chmod +x /tmp/bb-tracker/calls/login.sh
/tmp/bb-tracker/calls/login.sh
if [ ! -f ~/.config/bb-tracker/username.txt ]; then
echo -e "${RED}Incorrect apiKey, try again..${NC}"
echo "Username not detected - $log_timestamp" >> /tmp/bb-tracker/log.txt
rm ~/.config/bb-tracker/api-key.txt
api_key_setup
else
echo "Username detected - $log_timestamp" >> /tmp/bb-tracker/log.txt
fi
}

api_key_setup () {
touch ~/.config/bb-tracker/api-key.txt
touch ~/.config/bb-tracker/account-id.txt
unset bb_tracker_api_key
prompt="Enter BB apiKey: "
while IFS= read -p "$prompt" -r -s -n 1 char
do
    if [[ $char == $'\0' ]]
    then
        break
    fi
    prompt='*'
    bb_tracker_api_key+="$char"
done
echo
echo "$bb_tracker_api_key" > ~/.config/bb-tracker/api-key.txt
read -p "$(echo -e ${NC}"Enter account ID: "${NC})" ACCOUNT_ID
echo "$ACCOUNT_ID" > ~/.config/bb-tracker/account-id.txt
cd /tmp/bb-tracker/calls
wget https://raw.githubusercontent.com/Sod-ers/BB-Tracker/refs/heads/main/calls/login.sh 2> /dev/null
sed -i "s/replace-id/$ACCOUNT_ID/g" /tmp/bb-tracker/calls/login.sh
echo -e "${GREEN}apiKey Set.${NC}"
echo "apiKey set - $log_timestamp" >> /tmp/bb-tracker/log.txt
username_validator
}

api_key_validator () {
if [ ! -f ~/.config/bb-tracker/api-key.txt ]; then
echo -e "${RED}apiKey not detected..${NC}"
echo "apiKey not detected - $log_timestamp" >> /tmp/bb-tracker/log.txt
api_key_setup
else
echo -e "${GREEN}apiKey detected.${NC}"
echo "apiKey detected - $log_timestamp" >> /tmp/bb-tracker/log.txt
fi
}
api_key_validator

username=$(cat ~/.config/bb-tracker/username.txt)
echo -e "${YELLOW}Welcome, $username.${NC}"