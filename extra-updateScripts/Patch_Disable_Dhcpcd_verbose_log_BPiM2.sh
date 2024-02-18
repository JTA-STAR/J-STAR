#!/bin/bash
# Patch_Disable_Dhcpcd_verbose_log_BPiM2
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Disable_Dhcpcd_verbose_log_BPiM2.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw / 
 
echo "Disable dhcpcd verbose log, cause /var/log 64M full one moment, appear in BPiM2.";

dhcpcd_conf="/etc/dhcpcd.conf"
nohook_line="nohook syslog"

# 判断 /etc/dhcpcd.conf 是否存在
if [ -e "$dhcpcd_conf" ]; then
    # 检查文件中是否存在以 nohook syslog 开头的行
    #if ! grep -qF "^$nohook_line" "$dhcpcd_conf"; then  #判断不准，改为：
    if ! awk -v pattern="$nohook_line" '$0 ~ pattern { found=1; exit } END { exit !found }' "$dhcpcd_conf"; then
        # 在文件末尾添加 nohook syslog 行
        sudo bash -c "echo '$nohook_line' >> $dhcpcd_conf"
        echo "'nohook syslog' line added to the end of $dhcpcd_conf"
        cat $dhcpcd_conf

        # 重启 dhcpcd 服务
        sudo systemctl restart dhcpcd
        sudo dhclient -r
        sudo dhclient

        echo "dhcpcd service restarted, will takes effect now "
    else
        echo "'nohook syslog' line already exists in $dhcpcd_conf ,skip it"
    fi
else
    echo "Error: $dhcpcd_conf not found."
fi

echo "show me the size: /var/log/... "

find /var/log -type f -exec du -h --apparent-size {} + | sort -rh
du -h /var/log
echo "Shrink : /var/log/ the file size larger than 1MB"
find /var/log/ -type f -size +1M -exec sh -c 'tail -n 500 {} > {}' \;

echo "show me the size again: /var/log/... "
find /var/log -type f -exec du -h --apparent-size {} + | sort -rh
du -h /var/log


