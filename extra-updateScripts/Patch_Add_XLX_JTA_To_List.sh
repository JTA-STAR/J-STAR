#!/bin/bash
# Add to Pi-Star XLX reflector choose list
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Add_XLX_JTA_To_List.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw / 
 
sudo touch /root/XLXHosts.txt
#判断文件大小是否为0，为零时，sed插入无效
if [ ! -s /root/XLXHosts.txt ]; then
  sudo sh -c 'echo "" > /root/XLXHosts.txt' #sed 无法插入touch生成的空文件，先插入一个空格
else
  echo "文件大小不为零"
fi
#先删除行关键字的行：JTA;125.91.17.122;4004，这是不联46001的房间D
sudo sed -i  "/JTA;125.91.17.122;4004/d" /usr/local/etc/XLXHosts.txt
sudo sed -i  "/JTA;125.91.17.122;4004/d" /root/XLXHosts.txt 

#这是不联46001的房间C
sudo sed -i  "/JTAC;125.91.17.122;4003/d" /usr/local/etc/XLXHosts.txt
sudo sed -i  "/JTAC;125.91.17.122;4003/d" /root/XLXHosts.txt 

#在/usr/local/etc/XLXHosts.txt 插入行首：JTA;125.91.17.122;4004
sudo sed -i '1iJTA;125.91.17.122;4004'  /usr/local/etc/XLXHosts.txt
sudo sed -i '1iJTA;125.91.17.122;4004'  /root/XLXHosts.txt  #同时加入/root/XLXHosts.txt 避免更新时覆盖， 

#这是不联46001的房间C
sudo sed -i '1iJTAC;125.91.17.122;4003'  /usr/local/etc/XLXHosts.txt
sudo sed -i '1iJTAC;125.91.17.122;4003'  /root/XLXHosts.txt  #同时加入/root/XLXHosts.txt 避免更新时覆盖， 


echo "=============/usr/local/etc/XLXHosts.txt============="
cat /usr/local/etc/XLXHosts.txt |grep JTA

echo "=============/root/XLXHosts.txt============="
cat /root/XLXHosts.txt


sudo touch /root/DMR_Hosts.txt
#判断文件大小是否为0，为零时，sed插入无效
if [ ! -s /root/DMR_Hosts.txt ]; then
  sudo sh -c 'echo "" > /root/DMR_Hosts.txt' #sed 无法插入touch生成的空文件，先插入一个空格
else
  echo "文件大小不为零"
fi

#先删除关键字为：XLX_JTA的行
#在/usr/local/etc/DMR_Hosts.txt 找到第一个XLX，插入一行
sudo sed -i  "/XLX_JTA/d" /usr/local/etc/DMR_Hosts.txt
sudo sed -i  "/XLX_JTA/d" /root/DMR_Hosts.txt

#这是不联46001的房间C,TODO 其实上一句已经删掉 
sudo sed -i  "/XLX_JTAC/d" /usr/local/etc/DMR_Hosts.txt
sudo sed -i  "/XLX_JTAC/d" /root/DMR_Hosts.txt

#在/usr/local/etc/DMR_Hosts.txt 插入行首：“XLX_JTA             0000    125.91.17.122               passw0rd    62030” 
sudo sed -i '1iXLX_JTA\             0000\    125.91.17.122\               passw0rd\    62030'  /usr/local/etc/DMR_Hosts.txt
sudo sed -i '1iXLX_JTA\             0000\    125.91.17.122\               passw0rd\    62030'  /root/DMR_Hosts.txt #同时加入/root/DMR_Hosts.txt 避免更新时覆盖， 

#这是不联46001的房间C
sudo sed -i '1iXLX_JTAC\             0000\    125.91.17.122\               passw0rd\    62030'  /usr/local/etc/DMR_Hosts.txt
sudo sed -i '1iXLX_JTAC\             0000\    125.91.17.122\               passw0rd\    62030'  /root/DMR_Hosts.txt #同时加入/root/DMR_Hosts.txt 避免更新时覆盖， 

echo "=============/usr/local/etc/DMR_Hosts.txt============="
cat /usr/local/etc/DMR_Hosts.txt |grep XLX_JTA

echo "=============/root/DMR_Hosts.txt============="
cat /root/DMR_Hosts.txt

echo "Done" 