if grep -q -e surf_forbidden_ways_ksf -e surf_anzchamps -e surf_loves_spliff ~/BB-Tracker/Active-Maps.txt
then
map=$(cat ~/BB-Tracker/Active-Maps.txt)
echo "Current Maps:
$map" | mail -s "Favorite Map Detected" username@example.com
else
    echo "Not detected, do nothing."
fi
