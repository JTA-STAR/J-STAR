#!/bin/bash

# ���нű�����ļ����ص�/rootĿ¼
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/update_Pi-Star_MMDVMHost.sh | sudo sh

if [ "$(id -u)" != "0" ]; then
  echo -e "You need to be root to run this command...\n"
  exit 1
fi

mount -o remount,rw /
cd /home/pi-star;
sudo mkdir -p /home/pi-star/temp
sudo rm -rf /home/pi-startemp/MMDVMCal;
sudo rm -rf /home/pi-startemp/MMDVMHost;
sudo rm -rf /home/pi-star/temp/mmdvmhost.service;
cd /home/pi-star/temp/;

echo "Download MMDVMHost ..."
sudo curl -OL  https://www.bi7jta.cn/files/AndyTaylorTweet/Pi-Star_v4_Binaries_Bin/MMDVMHost;
sudo curl -OL  https://www.bi7jta.cn/files/AndyTaylorTweet/Pi-Star_v4_Binaries_Bin/MMDVMCal;  

sudo systemctl stop pistar-watchdog.service > /dev/null 2>&1
sudo systemctl stop mmdvmhost.service > /dev/null 2>&1 && sleep 2 > /dev/null 2>&1 

# Replace MMDVMHost with FM version;
sudo cp /home/pi-star/temp/MMDVMHost /usr/local/bin/MMDVMHost;
sudo cp /home/pi-star/temp/MMDVMCal /usr/local/bin/MMDVMCal;  

# ����Ȩ�ޣ�����Ȩ�޶�ʧ
sudo chmod 755 /usr/local/bin/MMDVMHost;
sudo chmod 755 /usr/local/bin/MMDVMCal;  


# TODO һ���ӱ�վ���º�git�汾�ᱻ�޸ģ�������Ҫ�ڻָ�ԭʼ���½ű�pistar-update 
# ����gitǿ�Ƹ�������Ա��´��ڹ�����������ʱ�ָ���

mount -o remount,ro /

sudo systemctl start pistar-watchdog.service# > /dev/null 2>&1
sudo systemctl start mmdvmhost.service > /dev/null 2>&1 && sleep 2 > /dev/null 2>&1

echo "Done";