#!/bin/bash
## Keep the BPiM2 betty WiFI not down
## sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Setup-pistar-watchdog-WiFi-Keep-Alive.sh | sudo sh

echo "Not need again after BPiM2 upgrade to buster, please flash the new IMG"
echo "Visit https://github.com/JTA-STAR/J-STAR"
sudo sed -i  "/\/usr\/local\/sbin\/pistar-watchdog-WiFi-Keep-Alive.sh/d" /etc/rc.local;
cat /etc/rc.local 
exit 1

CURTIME=`date "+%Y-%m-%d %H:%M:%S"`
echo "$CURTIME: Add sctipt to /etc/rc.local nohup /usr/local/sbin/pistar-watchdog-WiFi-Keep-Alive.sh &  " >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive.log

# Delete exist script
sudo sed -i  "/\/usr\/local\/sbin\/pistar-watchdog-WiFi-Keep-Alive.sh/d" /etc/rc.local;

# Obtain promise 
sudo sed -i '/exit/ i\chmod +x /usr/local/sbin/pistar-watchdog-WiFi-Keep-Alive.sh' /etc/rc.local

# Add watchdog script to bootup
sudo sed -i '/exit/ i\nohup /usr/local/sbin/pistar-watchdog-WiFi-Keep-Alive.sh &' /etc/rc.local
 
CURTIME=`date "+%Y-%m-%d %H:%M:%S"`
echo "$CURTIME: Add sctipt to /etc/rc.local done!  " >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive.log
echo "完成，重启生效！" 