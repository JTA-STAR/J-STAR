#!/bin/bash

# ���нű�����ļ����ص�/rootĿ¼
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/update_Pi-Star_DMRIdAndHosts.sh | sudo sh

if [ "$(id -u)" != "0" ]; then
  echo -e "You need to be root to run this command...\n"
  exit 1
fi

mount -o remount,rw /
cd /home/pi-star;

# ���·����������ļ���DMRID
echo "Download DMRIds and Hostfiles.." 

# Get the Pi-Star Version
pistarCurVersion=$(awk -F "= " '/Version/ {print $2}' /etc/pistar-release)
 
DMRIDFILE=/usr/local/etc/DMRIds.dat
DMRHOSTS=/usr/local/etc/DMR_Hosts.txt 
P25HOSTS=/usr/local/etc/P25Hosts.txt
YSFHOSTS=/usr/local/etc/YSFHosts.txt 

# Ĭ������£�curl�ǲ�����ʾ���ؽ��ȵġ����ǣ������ͨ��ʹ�á�-#����--progress-bar��ѡ�������ý����� -s����Ĭ������κ���Ϣ

sudo curl -#  -o ${DMRIDFILE}  http://125.91.17.122:8090/dmrids-and-hosts/DMRIds.dat --user-agent "Pi-Star_${pistarCurVersion}"
sudo curl -#  -o ${P25HOSTS}   http://125.91.17.122:8090/dmrids-and-hosts/P25_Hosts.txt --user-agent "Pi-Star_${pistarCurVersion}"
sudo curl -#  -o ${YSFHOSTS}   http://125.91.17.122:8090/dmrids-and-hosts/YSF_Hosts.txt --user-agent "Pi-Star_${pistarCurVersion}"
sudo curl -#  -o ${DMRHOSTS}   http://125.91.17.122:8090/dmrids-and-hosts/DMR_Hosts.txt --user-agent "Pi-Star_${pistarCurVersion}"

#sudo curl --fail -o ${DMRIDFILE} -s https://www.bi7jta.org/files/dmrids-and-hosts/DMRIds.dat --user-agent "Pi-Star_${pistarCurVersion}"
#sudo curl --fail -o ${P25HOSTS} -s https://www.bi7jta.org/files/dmrids-and-hosts/P25_Hosts.txt --user-agent "Pi-Star_${pistarCurVersion}"
#sudo curl --fail -o ${YSFHOSTS} -s https://www.bi7jta.org/files/dmrids-and-hosts/YSF_Hosts.txt --user-agent "Pi-Star_${pistarCurVersion}"
#sudo curl --fail -o ${DMRHOSTS} -s https://www.bi7jta.org/files/dmrids-and-hosts/DMR_Hosts.txt --user-agent "Pi-Star_${pistarCurVersion}"

mount -o remount,ro /

sudo systemctl stop pistar-watchdog.service > /dev/null 2>&1
sudo systemctl stop mmdvmhost.service > /dev/null 2>&1 && sleep 2 > /dev/null 2>&1 

sudo systemctl start pistar-watchdog.service# > /dev/null 2>&1
sudo systemctl start mmdvmhost.service #> /dev/null 2>&1 && sleep 2 > /dev/null 2>&1

ls -l /usr/local/etc

echo "Done. save to /usr/local/etc";


echo "Done";