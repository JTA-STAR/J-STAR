#!/bin/bash
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Change-Github-to-Gitee-And-Hard-update-dashboard.sh | sudo sh

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

echo "============================================================="
echo ""
echo "20231227更新：增加Windows10, macOS虚拟机的更新支持"
echo ""
echo "============================================================="

# 判断如果是Version = 3.4.17，不是以 Version = 4 （Version = 4.1.4） 开头，则不允许升级，提示先刷系统到4.1.4+
FIND_FILE="/etc/pistar-release"
FIND_STR="Version = 4"
FIND_WPSD="WPSD_Ver"

#这里判断不准确了！
if [ `grep -c "$FIND_STR" $FIND_FILE` -ne '0' ];then
    echo "Pi-Star V4+, update it"
    cat ${FIND_FILE}
else
    if [ `grep -c "$WPSD_Ver" $FIND_FILE` -ne '1' ];then
      echo "Pi-Star WPSD_Ver, replace it"
      cat ${FIND_FILE}
    else
      echo "监测到你正在使用的是Pi-Star低于V4版本，不支持直接升级，请先用SD卡刷V4.1.4以上的系统"
      echo "树莓派：http://www.pistar.uk/downloads/"
      echo "NanoPi/OrangePi：http://www.pistar.uk/beta/"
      cat ${FIND_FILE}
    exit 1
    fi
fi 

#用这种判断
STR_V3="Pi-Star_Binaries.git"
STR_BIN_DIR="/usr/local/bin/.git/config"
if [ `grep -c "$STR_V3" $STR_BIN_DIR` -ne '0' ];then
      echo "监测到你正在使用的bin是Pi-Star为V3版本，不支持直接升级，请先用SD卡刷V4.1.4以上的系统"
      echo "树莓派：http://www.pistar.uk/downloads/"
      echo "NanoPi/OrangePi：http://www.pistar.uk/beta/"
      cat ${STR_BIN_DIR} 
      exit 1
fi

cd /home/pi-star;

sudo mount -o remount,rw /
echo "国内Pi更新源经常无效，放弃！"
echo "使用官网的，反而能用到清华大学的源：http://mirrors.ustc.edu.cn/raspbian/raspbian buster/main"
#sudo sed -i  "s#raspbian.raspberrypi.org#mirrors.tuna.tsinghua.edu.cn#g" /etc/apt/sources.list

echo 'apt-get源：'
cat /etc/apt/sources.list

#sudo sed -i  "s#archive.raspberrypi.org#mirrors.tuna.tsinghua.edu.cn#g" /etc/apt/sources.list.d/raspi.list
echo 'raspi.list源：'
cat /etc/apt/sources.list.d/raspi.list

echo '更新更新服务器地址为国内, 务必增加sudo';
# TODO 需要处理异常

# BIN二进制程序
# 首先处理最原始的库为github的，只针对树莓派4桌面版，其它的不处理，处理完后，与W0CHP库没有关系了
sudo sed -i  "s#https://wpsd-swd.w0chp.net/WPSD-SWD/W0CHP-PiStar-bin.git#https://github.com/bi7jta/BI7JTA-PiStar-bin_RPi4B.git#g" /usr/local/bin/.git/config #新版WPSD2023
sudo sed -i  "s#https://repo.w0chp.net/WPSD-Dev/W0CHP-PiStar-bin.git#https://github.com/bi7jta/BI7JTA-PiStar-bin_RPi4B.git#g" /usr/local/bin/.git/config # 这里处理WPSD版本的bin项目
sudo sed -i  "s#https://github.com/AndyTaylorTweet/Pi-Star_v4_Binaries_Bin.git#https://github.com/bi7jta/BI7JTA-PiStar-bin_RPi4B.git#g" /usr/local/bin/.git/config # 这里处理MW0MWZ版本V4的bin项目
sudo sed -i  "s#https://gitee.com/BI7JTA/Pi-Star_v4_Binaries_Bin.git#https://github.com/bi7jta/BI7JTA-PiStar-bin_RPi4B.git#g" /usr/local/bin/.git/config # 这里V4执行了老脚本的情况
#sudo sed -i  "s#https://github.com/AndyTaylorTweet/Pi-Star_Binaries.git#https://github.com/bi7jta/BI7JTA-PiStar-bin_RPi4B.git#g" /usr/local/bin/.git/config #3.4.17版本不支持更新
sudo sed -i  "s#https://github.com/bi7jta/BI7JTA-PiStar-bin_RPi4B.git#https://gitee.com/BI7JTA/BI7JTA-PiStar-bin_RPi4B.git#g" /usr/local/bin/.git/config # 改github为gitee, debian 10/11

# 这里是处理BPiM2的 # BPi-M2专用，不通用，内核版本低debian9
sudo sed -i  "s#https://github.com/bi7jta/W0CHP-PiStar-bin_BPiM2.git#https://gitee.com/BI7JTA/W0CHP-PiStar-bin_BPiM2.git#g" /usr/local/bin/.git/config

# 处理Windows VisualBox
sudo sed -i  "s#https://github.com/GhostBassist/Lin-Star-Bin#https://github.com/bi7jta/Lin-Star-Bin_VisualBox.git#g" /usr/local/bin/.git/config # 这里处理处理Windows VisualBox
sudo sed -i  "s#https://github.com/bi7jta/Lin-Star-Bin_VisualBox.git#https://gitee.com/BI7JTA/Lin-Star-Bin_VisualBox.git#g" /usr/local/bin/.git/config # 改github为gitee, Windows VisualBox
                                                                     
echo 'bin源：';
cat /usr/local/bin/.git/config; 

echo "Updating /usr/local/bin ..."
git_update /usr/local/bin
echo "Done!\n"

# SBIN 通用脚本，所有Linux系统可共用
sudo sed -i  "s#https://wpsd-swd.w0chp.net/WPSD-SWD/W0CHP-PiStar-sbin.git#https://github.com/bi7jta/W0CHP-PiStar-sbin_BPiM2.git#g" /usr/local/sbin/.git/config #新版WPSD2023
sudo sed -i  "s#https://repo.w0chp.net/WPSD-Dev/W0CHP-PiStar-sbin.git#https://github.com/bi7jta/W0CHP-PiStar-sbin_BPiM2.git#g" /usr/local/sbin/.git/config     #旧版WPSD
sudo sed -i  "s#https://github.com/GhostBassist/Lin-Star-sBin#https://github.com/bi7jta/W0CHP-PiStar-sbin_BPiM2.git#g" /usr/local/sbin/.git/config             #X64 虚拟机
sudo sed -i  "s#https://github.com/AndyTaylorTweet/Pi-Star_Binaries_sbin.git#https://github.com/bi7jta/W0CHP-PiStar-sbin_BPiM2.git#g" /usr/local/sbin/.git/config #MW0MWZ版
sudo sed -i  "s#https://gitee.com/BI7JTA/Pi-Star_Binaries_sbin.git#https://github.com/bi7jta/W0CHP-PiStar-sbin_BPiM2.git#g" /usr/local/sbin/.git/config # 这里V4执行了老脚本的情况
sudo sed -i  "s#https://github.com/bi7jta/W0CHP-PiStar-sbin_BPiM2.git#https://gitee.com/BI7JTA/W0CHP-PiStar-sbin_BPiM2.git#g" /usr/local/sbin/.git/config #统一改为gitee
echo 'sbin源：'
cat /usr/local/sbin/.git/config;

echo "Updating /usr/local/sbin ..."
git_update /usr/local/sbin
echo "Done!\n"

sudo sed -i  "s#https://wpsd-swd.w0chp.net/WPSD-SWD/W0CHP-PiStar-Dash.git#https://github.com/bi7jta/W0CHP-PiStar-Dash_BPiM2.git#g" /var/www/dashboard/.git/config #新版WPSD2023
sudo sed -i  "s#https://repo.w0chp.net/WPSD-Dev/W0CHP-PiStar-Dash.git#https://github.com/bi7jta/W0CHP-PiStar-Dash_BPiM2.git#g" /var/www/dashboard/.git/config     #旧版W0CHP
sudo sed -i  "s#https://repo.w0chp.net/Chipster/W0CHP-PiStar-Dash.git#https://github.com/bi7jta/W0CHP-PiStar-Dash_BPiM2.git#g" /var/www/dashboard/.git/config     #X64 虚拟机
sudo sed -i  "s#https://github.com/AndyTaylorTweet/Pi-Star_DV_Dash.git#https://github.com/bi7jta/W0CHP-PiStar-Dash_BPiM2.git#g" /var/www/dashboard/.git/config    #MW0MWZ版
sudo sed -i  "s#https://gitee.com/BI7JTA/Pi-Star_DV_Dash.git#https://github.com/bi7jta/W0CHP-PiStar-Dash_BPiM2.git#g" /var/www/dashboard/.git/config              # 这里V4执行了老脚本的情况
sudo sed -i  "s#https://github.com/bi7jta/W0CHP-PiStar-Dash_BPiM2.git#https://gitee.com/BI7JTA/W0CHP-PiStar-Dash_BPiM2.git#g" /var/www/dashboard/.git/config
echo 'dashboard源：'
cat /var/www/dashboard/.git/config;


echo "Updating /var/www/dashboard ..."
git_update /var/www/dashboard
echo "Done!\n"


echo "All Done";
