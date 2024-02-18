#!/bin/bash
# Add_BPiM2_HDMI_Chrome_AutoStart
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Add_HDMI_Chrome_Full.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw /

sudo touch /tmp/tmpUpdatePath.log; 
sudo chmod 777 /tmp/tmpUpdatePath.log; 

autostartConfig="";
if [ -f /home/pi/.config/lxsession/LXDE-pi/autostart ]; then #BPiM2 betty
   autostartConfig="/home/pi/.config/lxsession/LXDE-pi/autostart";
   echo "Find BPiM2 betty config file in ${autostartConfig}"
else if [ -f "/home/pi-star/.config/lxsession/LXDE-pi/autostart" ]; then #RPi4B Desktop
   autostartConfig="/home/pi-star/.config/lxsession/LXDE-pi/autostart";
   echo "Find RPi4B Desktop config file in ${autostartConfig}"
   fi
fi

if [ autostartConfig != "" ]; then
	sudo sed -i "s#\<http:\/\/localhost/simple\>#http:\/\/localhost#g" ${autostartConfig} > /tmp/tmpUpdatePath.log; 
	cat ${autostartConfig}
fi
 
echo "完成，重启生效！Done, Reboot to use " 