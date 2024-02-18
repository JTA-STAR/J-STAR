#!/bin/bash
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Recover-Gitee-to-3.4.17-github.sh | sudo sh

git_update() {
	# Set the function variables
	gitFolder=${1} 
  git --work-tree=${gitFolder} --git-dir=${gitFolder}/.git reset --hard && git --work-tree=${gitFolder} --git-dir=${gitFolder}/.git clean -f #使本地完全回退到上次 commit
  # Git-忽略冲突，强制更新代码并覆盖本地代码
  git --work-tree=${gitFolder} --git-dir=${gitFolder}/.git fetch --all  
  # Reset local modified,
  git --work-tree=${gitFolder} --git-dir=${gitFolder}/.git reset --hard origin/master
  # Pull new updated,
  git --work-tree=${gitFolder} --git-dir=${gitFolder}/.git pull -q origin master 
}

if [ "$(id -u)" != "0" ]; then
  echo -e "You need to be root to run this command...\n"
  exit 1
fi
 
# 恢复到V3
FIND_FILE="/etc/pistar-release"
FIND_STR="Version = 3"

if [ `grep -c "$FIND_STR" $FIND_FILE` -ne '0' ];then
    echo "Pi-Star V3, revover it"
else
    echo "监测到你正在使用的是Pi-StarV4版本，不支持恢复到v3版本" 
    cat ${FIND_FILE}
    exit 1
fi 

cd /home/pi-star;
sudo mount -o remount,rw /

echo '更新更新服务器地址为国内, 务必增加sudo';
# TODO 需要处理异常
 
sudo sed -i  "s#https://gitee.com/BI7JTA/BI7JTA-PiStar-bin_RPi4B.git#https://github.com/AndyTaylorTweet/Pi-Star_Binaries.git#g" /usr/local/bin/.git/config #3.4.17版本不支持更新

echo 'bin源：';
cat /usr/local/bin/.git/config; 

echo "Updating /usr/local/bin ..."
git_update /usr/local/bin
echo "Done!\n"
 
sudo sed -i  "s#https://gitee.com/BI7JTA/W0CHP-PiStar-sbin_BPiM2.git#https://github.com/AndyTaylorTweet/Pi-Star_Binaries_sbin.git#g" /usr/local/sbin/.git/config 
echo 'sbin源：'
cat /usr/local/sbin/.git/config;

echo "Updating /usr/local/sbin ..."
git_update /usr/local/sbin
echo "Done!\n"
 
sudo sed -i  "s#https://gitee.com/BI7JTA/W0CHP-PiStar-Dash_BPiM2.git#https://github.com/AndyTaylorTweet/Pi-Star_DV_Dash.git#g" /var/www/dashboard/.git/config 
echo 'dashboard源：'
cat /var/www/dashboard/.git/config;


echo "Updating /var/www/dashboard ..."
git_update /var/www/dashboard
echo "Done!\n"


echo "All Done";
