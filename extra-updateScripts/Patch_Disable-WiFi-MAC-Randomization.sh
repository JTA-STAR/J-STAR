#!/bin/bash
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Disable-WiFi-MAC-Randomization.sh | sudo sh


# sudo vi /etc/NetworkManager/conf.d/100-disable-wifi-mac-randomization.conf
 
# 插入以下内容：

# [connection]
# wifi.mac-address-randomization=1

# [device]
# wifi.scan-rand-mac-address=no

# 重启树莓派

# reboot

# 小技巧：
# 卸载不好用的精简版vi， 
# sudo apt-get -y remove vim-common;
# 安装完整功能的vim
# sudo apt-get -y install vim  ;

# 问ChatGPT：
# 编写shell脚本，在文件
# /etc/NetworkManager/conf.d/100-disable-wifi-mac-randomization.conf
# 中查找包含
# [connection]
# wifi.mac-address-randomization
# 的行，删除，并插入
# [connection]
# wifi.mac-address-randomization=1
# ，

# 查找包含和包含
# [device]
# wifi.scan-rand-mac-address
# 的行，删除，并插入
# [device]
# wifi.scan-rand-mac-address=no

# 答案：
#!/bin/bash

# 检查文件是否存在
config_dir="/etc/NetworkManager/conf.d/"
config_file="/etc/NetworkManager/conf.d/100-disable-wifi-mac-randomization.conf"
if [ ! -e "$config_file" ]; then
    echo "文件 $config_file 不存在,Create it"
    mkdir -p ${config_dir}
    touch "$config_file" 
fi 

# 处理 [connection] wifi.mac-address-randomization
if grep -q "\[connection\]" "$config_file" && grep -q "wifi\.mac-address-randomization" "$config_file"; then
    sed -i '/^\[connection\]/,/^$/ s/wifi\.mac-address-randomization.*/wifi\.mac-address-randomization=1/' "$config_file"
else
    echo "[connection]\nwifi.mac-address-randomization=1" >> "$config_file"
fi

# 处理 [device] wifi.scan-rand-mac-address
if grep -q "\[device\]" "$config_file" && grep -q "wifi\.scan-rand-mac-address" "$config_file"; then
    sed -i '/^\[device\]/,/^$/ s/wifi\.scan-rand-mac-address.*/wifi\.scan-rand-mac-address=no/' "$config_file"
else
    echo "[device]\nwifi.scan-rand-mac-address=no" >> "$config_file"
fi 

cat ${config_file}
echo "脚本执行完毕"
