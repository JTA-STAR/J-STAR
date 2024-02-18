#!/bin/bash
# Add to Pi-Star FreeDMR Local server list
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Add_BM4601_47.100.76.205_To_ServerList.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw / 
 
#!/bin/bash

BM_China_LocalStr="BM_4601_China_47.100.76.205			4601	47.100.76.205	passw0rd	62031"

# 处理 /root/DMR_Hosts.txt 文件
dmr_hosts_file="/root/DMR_Hosts.txt"

# 如果文件不存在，则创建
if [ ! -e "$dmr_hosts_file" ]; then
    touch "$dmr_hosts_file"
fi

# 删除包含 BM_4601_China_47.100.76.205 字符串的行，并在末尾插入新行
sed -i '/^BM_4601_China_47.100.76.205/d' "$dmr_hosts_file"
echo "$BM_China_LocalStr" >> "$dmr_hosts_file"

# 显示文件内容
echo "文件 $dmr_hosts_file 的内容："
cat "$dmr_hosts_file"

# 处理 /usr/local/etc/DMR_Hosts.txt 文件
dmr_hosts_file_custom="/usr/local/etc/DMR_Hosts.txt"

# 删除包含 BM_4601_China_47.100.76.205 字符串的行，并在包含 BM_4601_China\t 字符串的行后插入新行,(注意：\t是TAB制表 符号)
sed -i '/^BM_4601_China_47.100.76.205/d' "$dmr_hosts_file_custom"
sed -i '/^BM_4601_China\t/a '"$BM_China_LocalStr" "$dmr_hosts_file_custom"

# 显示文件内容
echo "文件 $dmr_hosts_file_custom 的内容："
grep -i "BM_4601_China" "$dmr_hosts_file_custom"

 
