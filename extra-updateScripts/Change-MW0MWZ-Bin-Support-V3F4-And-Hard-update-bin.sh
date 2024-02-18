#!/bin/bash
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Change-MW0MWZ-Bin-Support-V3F4-And-Hard-update-bin.sh | sudo sh

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

sudo mount -o remount,rw /
 
sudo systemctl stop pistar-watchdog.timer
sudo systemctl stop pistar-watchdog.service
sudo systemctl stop mmdvmhost.timer
sudo systemctl stop mmdvmhost.service

# BIN二进制程序 
sudo sed -i  "s#https://github.com/AndyTaylorTweet/Pi-Star_v4_Binaries_Bin.git#https://gitee.com/BI7JTA/Pi-Star_v4_Binaries_Bin.git#g" /usr/local/bin/.git/config # 这里处理MW0MWZ版本V4的bin项目
                                                   
echo 'bin源：';
cat /usr/local/bin/.git/config; 

echo "Updating /usr/local/bin ..."
git_update /usr/local/bin
echo "Done!\n"

sudo systemctl start pistar-watchdog.timer
sudo systemctl start pistar-watchdog.service
sudo systemctl start mmdvmhost.timer
sudo systemctl start mmdvmhost.service

echo "All Done";
