# BB-Tracker
Scripts to detect map changes at BB Game Servers.

## Automatic Execution & Request Rate Adjustment:
Adjust the directory structure for your machine & add the following lines to your crontab file using the command ```crontab -e```.

```PATH=/bin:/usr/bin:/home/soders/BB-Tracker/```
```* * * * * bash -lc /home/soders/BB-Tracker/BB-Tracker.sh```
