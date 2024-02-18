#!/bin/bash

# 调用目标主机，执行系统更新命令：sudo pistar-update

# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Update-Pi-Star-OS.sh | sudo sh

if [ "$(id -u)" != "0" ]; then
  echo -e "You need to be root to run this command...\n"
  exit 1
fi

sudo cp /usr/local/sbin/pistar-update /usr/local/sbin/pistar-update.remote_update;
sudo sed -i  "/apt-get update/d" /usr/local/sbin/pistar-update.remote_update;
sudo sed -i  "/apt-get upgrade/d" /usr/local/sbin/pistar-update.remote_update;
sudo sed -i  "/apt-get clean/d" /usr/local/sbin/pistar-update.remote_update;
sudo mount -o remount,rw /;
sudo /usr/local/sbin/pistar-update.remote_update;