#!/bin/bash
# Fix the RPi4B output 1080p not full screen
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Support_HDMI_1080p_FullScrean_RPi4B.sh | sudo sh

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

sudo sed -i "/@xrandr -s 1920x1080/d" /home/pi-star/.config/lxsession/LXDE-pi/autostart
sudo sed -i '$a@xrandr -s 1920x1080' /home/pi-star/.config/lxsession/LXDE-pi/autostart
cat /home/pi-star/.config/lxsession/LXDE-pi/autostart
 
echo "完成，重启生效！Done, Reboot to use " 