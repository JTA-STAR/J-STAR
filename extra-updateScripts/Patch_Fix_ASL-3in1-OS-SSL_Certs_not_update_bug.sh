#!/bin/bash
# Fix Error, curl: (60) SSL certificate problem: unable to get local issuer certificate
# When curl from https://www.bi7jta.cn https://www.bi7jta.org
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Fix_ASL-3in1-OS-SSL_Certs_not_update_bug.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw / 

# 判断只有Allstarlink OS才执行此操作，其它环境无需处理
if [ -e /lib/systemd/system/asl-asterisk.service ]; then 
    echo "Is a ASL OS, run patch..."
else
	echo "Not an ASL OS, not need run this patch."
	exit 0
fi

cd /home/pi-star
rm -rf certs

#
if [ -e /usr/local/sbin/patch-scripts/certs.zip ]; then 
  echo "certs.zip exist"
else
  echo "/usr/local/sbin/patch-scripts/certs.zip Not exist, Now force update /usr/local/sbin"
  cd /usr/local/sbin
  git reset --hard && git clean -f #使本地完全回退到上次 commit
  git fetch --all
  # Reset local modified,
  git reset --hard origin/master
  # Pull new updated,
  git pull -q origin master 
  #会不会删除当前脚本文件？
fi

cd /home/pi-star

if [ -e /usr/local/sbin/patch-scripts/certs.zip ]; then 
  cp -f /usr/local/sbin/patch-scripts/certs.zip ./ 
  unzip certs.zip
  ls -lh certs/
else
  echo "After git update, /usr/local/sbin/patch-scripts/certs.zip Still Not exist, Error appear! "
  exit 1
fi

cp -rf certs/* /etc/ssl/certs/

TestURL="https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Fix_ASL-3in1-OS-SSL_Certs_not_update_bug.sh"
echo "Test if ok ? ${TestURL}"

curl -OL ${TestURL}
 
echo "Done" 