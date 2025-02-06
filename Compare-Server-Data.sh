#!/bin/bash

# Compare last known maps to current maps
diff --brief <(sort ~/BB-Tracker/Active-Maps.txt) <(sort ~/BB-Tracker/Active-Server-Data-Temp.txt) >/dev/null
comp_value=$?
if [ $comp_value -eq 1 ]
then
map=$(cat ~/BB-Tracker/Active-Maps.txt)
time=$(cat ~/BB-Tracker/Time.txt)
echo "Current Maps:
$map" >> /dev/usb/lp0; echo "Current Maps:
$map" >> /dev/usb/lp1; echo "Current Maps:
$map" >> /dev/usb/lp2
echo "$time" >> /dev/usb/lp0; echo "$time" >> /dev/usb/lp1; echo "$time" >> /dev/usb/lp2

lpr -o fit-to-page -o media=Custom.70x25mm -P EPSON_TM-T20II ~/BB-Tracker/QR.jpg
~/BB-Tracker/Email-Me.sh
sleep 5
lprm
else
echo "No change detected, do nothing"
fi
