#!/bin/bash
# Patch_Support_RPi5B
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Support_RPi5B.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw /
sudo mount -o remount,rw /boot

sudo touch /tmp/tmpUpdatePath.log; 
sudo chmod 777 /tmp/tmpUpdatePath.log; 

autostartConfig="/boot/config.txt";
if [ -f ${autostartConfig} ]; then  
	sudo sed -i "/set\ os_check=0/d" ${autostartConfig}  
	sudo sed -i "/os_check=0/d" ${autostartConfig}  
    sudo sed -i '$aos_check=0' ${autostartConfig}  

	cat ${autostartConfig}
fi
 
echo "完成，将卡放到5B使用！Done" 