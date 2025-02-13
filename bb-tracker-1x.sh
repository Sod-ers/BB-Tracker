#!/bin/bash

~/BB-Tracker/BB-Tracker-Silent.sh

map=$(cat /tmp/BB-Tracker/Active-Maps.txt)
time=$(cat /tmp/BB-Tracker/Time.txt)
echo "Current Maps:
$map" >> /dev/usb/lp0; echo "Current Maps:
$map" >> /dev/usb/lp1; echo "Current Maps:
$map" >> /dev/usb/lp2
echo "$time" >> /dev/usb/lp0; echo "$time" >> /dev/usb/lp1; echo "$time" >> /dev/usb/lp2
lpr -o fit-to-page -o media=Custom.70x25mm -P EPSON_TM-T20II ~/BB-Tracker/QR.jpg
sleep 5
lprm
