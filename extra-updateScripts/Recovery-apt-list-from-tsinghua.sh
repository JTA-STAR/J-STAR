#!/bin/bash
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Recovery-apt-list-from-tsinghua.sh | sudo sh
if [ "$(id -u)" != "0" ]; then
  echo -e "You need to be root to run this command...\n"
  exit 1
fi 

sudo mount -o remount,rw /
sudo sed -i  "s#mirrors.tuna.tsinghua.edu.cn#raspbian.raspberrypi.org#g" /etc/apt/sources.list
# 删除-src提升速度
sudo sed -i "/deb-src/d" /etc/apt/sources.list

echo 'apt-get源：'
cat /etc/apt/sources.list

sudo sed -i  "s#mirrors.tuna.tsinghua.edu.cn#archive.raspberrypi.org#g" /etc/apt/sources.list.d/raspi.list
# 删除-src提升速度
sudo sed -i "/deb-src/d" /etc/apt/sources.list.d/raspi.list

echo 'raspi.list源：'
cat /etc/apt/sources.list.d/raspi.list

echo "Done";
