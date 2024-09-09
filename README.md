# BB-Tracker
Scripts to detect map changes at BB Game Servers.

## Automatic Execution & Request Rate Adjustment:
Adjust the directory structure for your machine & add the following lines to your crontab file using the command ```crontab -e```.

```PATH=/bin:/usr/bin:/home/soders/BB-Tracker/```

```* * * * * bash -lc /home/soders/BB-Tracker/BB-Tracker.sh```

Set the path so the system will recognize the script.

Adjust the rate of execution by changing the star values. The current configuration executes every minute.
https://crontab.guru/ is a good resource for this.
