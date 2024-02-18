#!/bin/bash

## sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/update-NextionDriver-DMRId.sh | sudo sh

sudo mount -o remount,rw /
cd /tmp; sudo rm -f user.*; sudo wget https://www.bi7jta.cn/files/dmrids-and-hosts/user.zip

cd /tmp; sudo unzip user.zip
stat /tmp/user.csv
sudo mv /tmp/user.csv /usr/local/etc/stripped.csv
stat /usr/local/etc/stripped.csv
sudo systemctl restart nextiondriver
#sudo systemctl status nextiondriver
sudo systemctl restart mmdvmhost
#sudo systemctl status mmdvmhost

echo "更新完成！"