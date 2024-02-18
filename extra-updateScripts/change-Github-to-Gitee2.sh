#!/bin/bash

# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/change-Github-to-Gitee.sh | sudo sh

if [ "$(id -u)" != "0" ]; then
  echo -e "You need to be root to run this command...\n"
  exit 1
fi
 
cd /home/pi-star;

sudo mount -o remount,rw /
sudo sed -i  "s#raspbian.raspberrypi.org#mirrors.tuna.tsinghua.edu.cn#g" /etc/apt/sources.list

echo 'apt-get源：'
cat /etc/apt/sources.list

sudo sed -i  "s#archive.raspberrypi.org#mirrors.tuna.tsinghua.edu.cn#g" /etc/apt/sources.list.d/raspi.list
echo 'raspi.list源：'
cat /etc/apt/sources.list.d/raspi.list

echo '更新更新服务器地址为国内, 务必增加sudo';
# TODO 需要处理异常
# BPi-M2专用
        
sudo sed -i  "s#https://github.com/bi7jta/W0CHP-PiStar-bin_BPiM2.git#https://gitee.com/BI7JTA/W0CHP-PiStar-bin_BPiM2.git#g" /usr/local/bin/.git/config

#W0CHP官方库专用
sudo sed -i  "s#https://repo.w0chp.net/Chipster/W0CHP-PiStar-bin.git#https://gitee.com/BI7JTA/W0CHP-PiStar-bin.git#g" /usr/local/bin/.git/config

#Pi-Star4.x专用
sudo sed -i "s#https://github.com/AndyTaylorTweet/Pi-Star_v4_Binaries_Bin.git#https://gitee.com/BI7JTA/Pi-Star_v4_Binaries_Bin.git#g" /usr/local/bin/.git/config

echo 'bin源：';
cat /usr/local/bin/.git/config;

sudo sed -i  "s#https://github.com/bi7jta/W0CHP-PiStar-sbin_BPiM2.git#https://gitee.com/BI7JTA/W0CHP-PiStar-sbin_BPiM2.git#g" /usr/local/sbin/.git/config
sudo sed -i  "s#https://repo.w0chp.net/Chipster/W0CHP-PiStar-sbin.git#https://gitee.com/BI7JTA/W0CHP-PiStar-sbin.git#g" /usr/local/sbin/.git/config
sudo sed -i  "s#https://github.com/AndyTaylorTweet/Pi-Star_Binaries_sbin.git#https://gitee.com/BI7JTA/Pi-Star_Binaries_sbin.git#g" /usr/local/sbin/.git/config
echo 'sbin源：'
cat /usr/local/sbin/.git/config;


sudo sed -i  "s#https://github.com/bi7jta/W0CHP-PiStar-Dash_BPiM2.git#https://gitee.com/BI7JTA/W0CHP-PiStar-Dash_BPiM2.git#g" /var/www/dashboard/.git/config
sudo sed -i  "s#https://repo.w0chp.net/Chipster/W0CHP-PiStar-Dash.git#https://gitee.com/BI7JTA/W0CHP-PiStar-Dash.git#g" /var/www/dashboard/.git/config
sudo sed -i  "s#https://github.com/AndyTaylorTweet/Pi-Star_DV_Dash.git#https://gitee.com/BI7JTA/Pi-Star_DV_Dash.git#g" /var/www/dashboard/.git/config

echo 'dashboard源：'
cat /var/www/dashboard/.git/config;


echo "Done";

