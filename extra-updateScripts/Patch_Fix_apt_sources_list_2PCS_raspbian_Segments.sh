#!/bin/bash
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Fix_apt_sources_list_2PCS_raspbian_Segments.sh | sudo sh
if [ "$(id -u)" != "0" ]; then
  echo -e "You need to be root to run this command...\n"
  exit 1
fi 

sudo mount -o remount,rw /
# 修复多余的/raspbian
sudo sed -i 's#/raspbian/raspbian/#/raspbian/#g' /etc/apt/sources.list
 

echo "Done";
