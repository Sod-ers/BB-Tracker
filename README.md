![1](https://github.com/Sod-ers/BB-Tracker/blob/main/bb-tracker-2.0.png)

## Results:
When a map change is detected, print relevant info. Scanning the qr code sends a command to join the server:
>```steam steam://connect/149.56.38.33:27015```

![1](https://github.com/Sod-ers/BB-Tracker/blob/main/Examples/1.jpg)

Asking Siri for the current maps:\
![2](https://github.com/Sod-ers/BB-Tracker/blob/main/Examples/2.jpg)

Receiving an email when any of my favorite maps are detected:\
![3](https://github.com/Sod-ers/BB-Tracker/blob/main/Examples/3.jpg)

## bb-tracker-printer.sh:

### Automatic Execution & Request Rate Adjustment:
Adjust the directory structure for your system & add the following code blocks to your crontab file using the command ```crontab -e```.

> Adjust the rate of execution by changing the star values. The current configuration executes every minute.

```* * * * * bash -lc /home/soders/.local/bin/bb-tracker-printer.sh > /dev/null 2>&1&```

> [!TIP]
> https://cron.help/ is a good resource for this.

### Enable & Disable:
> Revoke permissions to execute the script. +x to enable.

```chmod -x "/.local/bin/bb-tracker-printer.sh"```

### Troubleshooting:
- Check executable permissons on each script.
- /dev/usb/lp1 may change, I print to lp0-2 to avoid this issue. You need to add your user to the group to have printing permissions.
> Example: ```sudo usermod -a -G lp soders```
- Any other errors: Bailing out, you are on your own. Good luck.
### Dependencies:
BB GraphQL api key\
Postfix\
S-nail\
Mailutils\
Epson TM-T20II Software & Documents Disc (tmx-cups-2.0.3.0.tar.gz)\
CUPS
