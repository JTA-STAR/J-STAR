#!/bin/bash
 
# Remount root as writable
sudo mount -o remount,rw /

echo "execute：sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Add_FullEdit_MMDVMHost_to-MW0MWZ_PI-STAR_V_4.2.0.sh | sudo sh "

fulledit_mmdvmhost="/var/www/dashboard/admin/expert/fulledit_mmdvmhost.php"
header_menu_inc="/var/www/dashboard/admin/expert/header-menu.inc"

curl -# -o ${fulledit_mmdvmhost}  https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/patch/MW0MWZ/fulledit_mmdvmhost.inc
curl -# -o ${header_menu_inc}  https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/patch/MW0MWZ/header-menu.inc


echo "DONE!"
