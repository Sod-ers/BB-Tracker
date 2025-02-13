#!/bin/bash

source ~/BB-Tracker/.env

if grep -q -e surf_utopia_njv -e surf_forbidden_ways_ksf -e surf_anzchamps -e surf_loves_spliff /tmp/BB-Tracker/Active-Maps.txt
then
map=$(cat /tmp/BB-Tracker/Active-Maps.txt)
echo "Current Maps:
$map" | mail -s "Favorite Map Detected" $email
else
    echo "Not detected, do nothing."
fi
