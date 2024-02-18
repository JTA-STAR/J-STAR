#!/bin/bash
# FIX_I2C_OLED_NOT_ENABLE
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_FIX_I2C_OLED_NOT_ENABLE.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw / 
sudo mount -o remount,rw /boot
 
config_file="/boot/config.txt"
search_pattern="#.*dtparam=i2c_arm=on$"
insert_line="dtparam=i2c_arm=on"

# 检查是否存在包含指定模式的行
if grep -qE "$search_pattern" "$config_file"; then
  # 如果存在，去掉注释符号
  sudo sed -i -E "s/$search_pattern/$insert_line/" "$config_file"
  echo "I2C NOT set, enable it"
  grep -i "$insert_line" "$config_file"  
fi

# 再次检查是否存在以dtparam=i2c_arm=on开头的行
if ! grep -qE "^$insert_line" "$config_file"; then
  echo "不存在，${insert_line} , 插入新行到文件末尾"
  echo "$insert_line" | sudo tee -a "$config_file"
  grep -i "$insert_line" "$config_file" 

fi

cat "$config_file" 

echo "DONE! Reboot to use I2C_OLED display"
echo "完成，重启你的热点，让OLED配置生效"