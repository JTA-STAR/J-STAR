#!/bin/bash
## Keep the NEO WiFI not down
## sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Setup-pistar-watchdog-WiFi-Keep-Alive_NEO.sh | sudo sh

echo "Not need again after BPiM2 upgrade to buster, please flash the new IMG"
echo "Visit https://github.com/JTA-STAR/J-STAR"
sudo sed -i  "/\/home\/pi-star\/pistar-watchdog-WiFi-Keep-Alive_NEO.sh/d" /etc/rc.local;
cat /etc/rc.local
exit 1

CURTIME=`date "+%Y-%m-%d %H:%M:%S"`
echo "$CURTIME: Add sctipt to /etc/rc.local nohup /home/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.sh &  " >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log

rpi-rw;
cd /home/pi-star
rm -rf pistar-watchdog-WiFi-Keep-Alive_NEO.sh
remoteExecuteFile="https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/pistar-watchdog-WiFi-Keep-Alive_NEO.sh"

echo "Downloading file ${remoteExecuteFile}" >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log
sudo curl -OL ${remoteExecuteFile};

# Delete exist script
sudo sed -i  "/\/home\/pi-star\/pistar-watchdog-WiFi-Keep-Alive_NEO.sh/d" /etc/rc.local;

# Obtain promise 
sudo sed -i '/exit/ i\chmod +x /home/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.sh' /etc/rc.local

# Add watchdog script to bootup
sudo sed -i '/exit/ i\nohup /home/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.sh &' /etc/rc.local
 
CURTIME=`date "+%Y-%m-%d %H:%M:%S"`
echo "$CURTIME: Add sctipt to /etc/rc.local done!  " >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log
echo "完成，重启生效！Done, Reboot to use " 