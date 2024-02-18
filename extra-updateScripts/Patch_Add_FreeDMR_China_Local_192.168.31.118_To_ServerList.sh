#!/bin/bash
# Add to Pi-Star FreeDMR Local server list
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Add_FreeDMR_China_Local_192.168.31.118_To_ServerList.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw / 
 
#!/bin/bash

FreeDMR_China_LocalStr="FreeDMR_China_Local_192.168.31.118        9999    192.168.31.118                passw0rd    62031"

# 处理 /root/DMR_Hosts.txt 文件
dmr_hosts_file="/root/DMR_Hosts.txt"

# 如果文件不存在，则创建
if [ ! -e "$dmr_hosts_file" ]; then
    touch "$dmr_hosts_file"
fi

# 删除包含 FreeDMR_China_Local 字符串的行，并在末尾插入新行
sed -i '/^FreeDMR_China_Local_192.168.31.118 /d' "$dmr_hosts_file"
echo "$FreeDMR_China_LocalStr" >> "$dmr_hosts_file"

# 显示文件内容
echo "文件 $dmr_hosts_file 的内容："
cat "$dmr_hosts_file"

# 处理 /usr/local/etc/DMR_Hosts.txt 文件
dmr_hosts_file_custom="/usr/local/etc/DMR_Hosts.txt"

# 删除包含 FreeDMR_China_Local 字符串的行，并在包含 FreeDMR_China\t 字符串的行后插入新行,(注意：\t是TAB制表 符号)
sed -i '/^FreeDMR_China_Local_192.168.31.118 /d' "$dmr_hosts_file_custom"
sed -i '/^FreeDMR_China\t/a '"$FreeDMR_China_LocalStr" "$dmr_hosts_file_custom"

# 显示文件内容
echo "文件 $dmr_hosts_file_custom 的内容："
cat "$dmr_hosts_file_custom"


echo "====================/etc/dmrgateway freeDMR Config sample ================="
echo "[DMR Network 2]"
echo "Enabled=1"
echo "Address=192.168.2.33"
echo "Port=62031"
echo "TGRewrite0=2,9,2,9,1"
echo "PCRewrite0=2,94000,2,4000,1001"
echo "TypeRewrite0=2,9990,2,9990"
echo "SrcRewrite0=2,4000,2,9,1001"
echo "PassAllPC0=1"
echo "PassAllTG0=1"
echo "PassAllPC1=2"
echo "PassAllTG1=2"
echo 'Password="passw0rd"'
echo "Debug=1"
echo "Id=460072402"
echo "Location=0"
echo "Name=FreeDMR_China_Local_192.168.31.118 "
echo '#Simplex Mode,Static TG'
echo 'Options="TS2=460755;TIMER=15"'
echo '#Duplex mode'
echo 'Options="TS1=46001;TS2=460755;DIAL=0;TIMER=10;"'
