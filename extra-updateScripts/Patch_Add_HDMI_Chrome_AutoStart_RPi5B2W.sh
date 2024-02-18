#!/bin/bash
echo "=========== 树莓派5B,2W 理论上发布基础IMG时已经包含，不需要执行此脚本，仅供自己使用 ==========="
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Add_HDMI_Chrome_AutoStart_RPi5B2W.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw /
sudo mount -o remount,rw /boot

# 前提，先安装桌面组件，刷桌面版pi-star
# 替换开机检测分辨率，
sudo sed -i  "s#\#hdmi_force_hotplug=1#hdmi_force_hotplug=1#g"  /boot/config.txt 
sudo sed -i  "s#\#hdmi_group=1#hdmi_group=2#g"  /boot/config.txt 
sudo sed -i  "s#\#hdmi_mode=1#hdmi_mode=82#g"  /boot/config.txt 
cat  /boot/config.txt 

# 删除以支持重复执行
sudo sed -i  "/@xrandr -s 1920x1080/d" /etc/xdg/lxsession/LXDE-pi/autostart
sudo sed -i '$a@xrandr -s 1920x1080'  /etc/xdg/lxsession/LXDE-pi/autostart  
cat /etc/xdg/lxsession/LXDE-pi/autostart
 
file_path="/home/pi-star/.config/lxsession/LXDE-pi/autostart"
parent_directory="$(dirname "$file_path")"
content="@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xscreensaver -no-splash
@point-rpi
@xset s off
@xset s noblank
@xset -dpms
@chromium-browser --noerrdialogs --start-fullscreen --incognito http://localhost
@xrandr -s 1920x1080"

# 检查目录是否存在
if [ -d "/home/pi-star/" ]; then
    # 检查文件是否存在
    if [ ! -f "$file_path" ]; then
        # 创建父目录
        mkdir -p "$parent_directory"
        
        # 将内容写入文件
        echo "$content" > "$file_path"
        
        echo "文件创建并写入成功"
    else
        echo "文件已经存在，不需要创建"
    fi
else
    echo "目录 /home/pi-star/ 不存在"
fi

 
echo "完成，重启生效！Done, Reboot to use " 