#!/bin/bash
# Disable OS_Unattended_upgrades, high CPU cost
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Remove_OS_Unattended_upgrades.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw /

sudo touch /tmp/tmpUpdatePath.log; 
sudo chmod 777 /tmp/tmpUpdatePath.log; 

sudo apt remove -y unattended-upgrades

top -n 1
 
echo "完成，已经生效！Done, now to use " 