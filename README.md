# BB-Tracker
Scripts to detect map changes at BB Game Servers.

## Dependencies:
BB GraphQL api key\
Postfix\
S-nail\
Mailutils\
Epson TM-T20II Software & Documents Disc (tmx-cups-2.0.3.0.tar.gz)

## Automatic Execution & Request Rate Adjustment:
Adjust the directory structure for your system & add the following code blocks to your crontab file using the command ```crontab -e```.

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

## Results:
If a map change is detected, print the relevant info. Scanning the qr code sends a command to join the server.\
```steam steam://connect/149.56.38.33:27015```\
![1](https://github.com/Sod-ers/BB-Tracker/blob/main/Examples/1.jpg)

I can ask Siri what the current maps are.\
![2](https://github.com/Sod-ers/BB-Tracker/blob/main/Examples/2.jpg)

I receive an email when any of my favorite maps are detected.\
![3](https://github.com/Sod-ers/BB-Tracker/blob/main/Examples/3.jpg)

## Troubleshooting:
- Check executable permissons on each script.
- /dev/usb/lp1 may change, I print to lp0-2 to avoid this issue. You need to add your user to the group to have printing permissions.
> Example: ```sudo usermod -a -G lp soders```
- Any other errors: Bailing out, you are on your own. Good luck.

