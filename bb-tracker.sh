#!/bin/bash

NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

mkdir /tmp/bb-tracker/ 2> /dev/null
mkdir /tmp/bb-tracker/calls/ 2> /dev/null
mkdir /tmp/bb-tracker/json/ 2> /dev/null
mkdir /tmp/bb-tracker/txt/ 2> /dev/null
touch /tmp/bb-tracker/log.txt
mkdir ~/.config/bb-tracker/ 2> /dev/null
log_timestamp=$(date "+%D  %I:%M:%S %p")

api_key_setup () {
rm ~/.config/bb-tracker/api-key.txt 2> /dev/null & rm ~/.config/bb-tracker/username.txt 2> /dev/null & rm ~/.config/bb-tracker/account-id.txt 2> /dev/null & rm /tmp/bb-tracker/calls/login.sh 2> /dev/null

echo -e "${RED}Configuration missing or incorrect..${NC}"

prompt="Enter BB api key: "
bb_tracker_api_key=""

stty -echo

printf "$prompt"

while IFS= read -r -s -n1 char; do
  if [[ $char == $'\0' ]]; then
    break
  elif [[ $char == $'\177' ]]; then
    if [ ${#bb_tracker_api_key} -gt 0 ]; then
      bb_tracker_api_key="${bb_tracker_api_key%?}"
      printf "\b \b"
    fi
  else
    bb_tracker_api_key+="$char"
    printf "*"
  fi
done

stty echo
printf "\n"

touch ~/.config/bb-tracker/api-key.txt
echo $bb_tracker_api_key > ~/.config/bb-tracker/api-key.txt
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
if [ ! -f ~/.config/bb-tracker/api-key.txt ]; then
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

api_key=$(cat ~/.config/bb-tracker/api-key.txt 2>/dev/null)

platinum_check () {
ACCOUNT_ID=$(cat ~/.config/bb-tracker/account-id.txt)
wget -O /tmp/bb-tracker/calls/platinum_check.sh https://raw.githubusercontent.com/Sod-ers/BB-Tracker/refs/heads/main/calls/platinum_check.sh 2> /dev/null
sed -i "s/replace-id/$ACCOUNT_ID/g" /tmp/bb-tracker/calls/platinum_check.sh
bash /tmp/bb-tracker/calls/platinum_check.sh
}

username=$(cat ~/.config/bb-tracker/username.txt)
echo -e "${YELLOW}Welcome to BB Tracker 2.0, $username.${NC}"

printf "\033]0;%s\a" "BB Tracker"
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
platinum_check
cat /tmp/bb-tracker/txt/platinum_status.txt
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
if [ ! -f ~/.config/bb-tracker/thermal-printer.txt ]; then
echo -e "${RED}Thermal printer not connected. Visit BB-Tracker on GitHub for instructions.${NC}" && sleep 3
bash /tmp/bb-tracker.sh 
else
echo -e "${GREEN}Supported.${NC}"
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