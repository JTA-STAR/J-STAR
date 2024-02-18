#!/bin/bash
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Recovery-Github-from-Gitee.sh | sudo sh
if [ "$(id -u)" != "0" ]; then
  echo -e "You need to be root to run this command...\n"
  exit 1
fi
 
cd /home/pi-star;

sudo mount -o remount,rw /
sudo sed -i  "s#mirrors.tuna.tsinghua.edu.cn#raspbian.raspberrypi.org#g" /etc/apt/sources.list

echo 'apt-get源：'
cat /etc/apt/sources.list

sudo sed -i  "s#mirrors.tuna.tsinghua.edu.cn#archive.raspberrypi.org#g" /etc/apt/sources.list.d/raspi.list
echo 'raspi.list源：'
cat /etc/apt/sources.list.d/raspi.list

echo '更新更新服务器地址为国内, 务必增加sudo';
# TODO 需要处理异常

# 首先处理最原始的库为github的，只针对树莓派4桌面版，其它的不处理，处理完后，与W0CHP库没有关系了
sudo sed -i  "s#https://repo.w0chp.net/WPSD-Dev/W0CHP-PiStar-bin.git#https://github.com/bi7jta/BI7JTA-PiStar-bin_RPi4B.git#g" /usr/local/bin/.git/config
sudo sed -i  "s#https://gitee.com/BI7JTA/BI7JTA-PiStar-bin_RPi4B.git#https://github.com/bi7jta/BI7JTA-PiStar-bin_RPi4B.git#g" /usr/local/bin/.git/config

# 这里是处理BPiM2的 # BPi-M2专用   
sudo sed -i  "s#https://gitee.com/BI7JTA/W0CHP-PiStar-bin_BPiM2.git#https://github.com/bi7jta/W0CHP-PiStar-bin_BPiM2.git#g" /usr/local/bin/.git/config
echo 'bin源：';
cat /usr/local/bin/.git/config;

sudo sed -i  "s#https://repo.w0chp.net/WPSD-Dev/W0CHP-PiStar-sbin.git#https://github.com/bi7jta/W0CHP-PiStar-sbin_BPiM2.git#g" /usr/local/sbin/.git/config
sudo sed -i  "s#https://gitee.com/BI7JTA/W0CHP-PiStar-sbin_BPiM2.git#https://github.com/bi7jta/W0CHP-PiStar-sbin_BPiM2.git#g" /usr/local/sbin/.git/config
echo 'sbin源：'
cat /usr/local/sbin/.git/config;

sudo sed -i  "s#https://repo.w0chp.net/WPSD-Dev/W0CHP-PiStar-Dash.git#https://github.com/bi7jta/W0CHP-PiStar-Dash_BPiM2.git#g" /var/www/dashboard/.git/config
sudo sed -i  "s#https://gitee.com/BI7JTA/W0CHP-PiStar-Dash_BPiM2.git#https://github.com/bi7jta/W0CHP-PiStar-Dash_BPiM2.git#g" /var/www/dashboard/.git/config
echo 'dashboard源：'
cat /var/www/dashboard/.git/config;


echo "Done";
