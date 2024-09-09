# BB-Tracker
Scripts to detect map changes at BB Game Servers.

## Dependencies:
Postfix\
S-nail\
Mailutils\
Epson TM-T20II Software & Documents Disc (tmx-cups-2.0.3.0.tar.gz)\
[Generate QR code for shortcut](https://www.icloud.com/shortcuts/aa7df045d7d44df4a41698014e80e1c2)

## Automatic Execution & Request Rate Adjustment:
Adjust the directory structure for your machine & add the following code blocks to your crontab file using the command ```crontab -e```.

> Set the path so the system will recognize the script.
> 
```PATH=/bin:/usr/bin:/home/soders/BB-Tracker/```

> Adjust the rate of execution by changing the star values. The current configuration executes every minute.

```* * * * * bash -lc /home/soders/BB-Tracker/BB-Tracker.sh```

> [!TIP]
> https://crontab.guru/ is a good resource for this.

## Enabling & Disabling:
> Revoke permissions to execute the script. +x to enable.

```chmod -x "~/BB-Tracker/BB-Tracker.sh"```
