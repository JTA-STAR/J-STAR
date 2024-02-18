#!/bin/bash
#  
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Fix_P25GatewayConfig.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw /

sudo touch /tmp/tmpUpdatePath.log; 
sudo chmod 777 /tmp/tmpUpdatePath.log; 

#FIX p25gateway no data 
FIND_STR="\[Network\]"
if [ `grep -c "$FIND_STR" /etc/p25gateway ` -ne '0' ];then
  echo "Find $FIND_STR in p25gateway, ignore it."
else
  echo "${FIND_STR} NOT FOUND, fix it"
  cp /usr/local/sbin/patch-scripts/p25gateway.txt /etc/p25gateway
fi
cat /etc/p25gateway
 
echo "完成，刷新生效！Done, refresh to use " 