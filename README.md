# BB-Tracker
Scripts to detect map changes at BB Game Servers.

## Automatic Execution & Request Rate Adjustment:
Adjust the directory structure for your machine & add the following code blocks to your crontab file using the command ```crontab -e```.

Set the path so the system will recognize the script.
  ```PATH=/bin:/usr/bin:/home/soders/BB-Tracker/```


```* * * * * bash -lc /home/soders/BB-Tracker/BB-Tracker.sh```
Adjust the rate of execution by changing the star values. The current configuration executes every minute.

> [!TIP]
> https://crontab.guru/ is a good resource for this.
