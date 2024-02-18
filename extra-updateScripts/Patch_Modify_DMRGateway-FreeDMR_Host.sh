#!/bin/bash
# Add to Pi-Star FreeDMR Local server list
# sudo curl -o Patch_Modify_DMRGateway-FreeDMR_Host.sh  https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Modify_DMRGateway-FreeDMR_Host.sh 
# sudo sh Patch_Modify_DMRGateway-FreeDMR_Host.sh 192.168.31.118



# Remount root as writable
sudo mount -o remount,rw /   

file_path="/etc/dmrgateway"

# 检查参数是否传入
if [ "$#" -ne 1 ]; then
    echo "请提供一个参数作为新的 DMR 地址"
    exit 1
fi

# 传入的参数作为新的 DMR 地址
freeDMRHost="$1"
echo "传入参数为：$freeDMRHost "

# 检查文件是否存在
if [ -e "$file_path" ]; then
    # 使用sed命令进行替换
    # 不成功！问ChatGPT
    # sed -i "s/\[DMR Network 2\]\nEnabled=1\nAddress=.*/[DMR Network 2]\nEnabled=1\nAddress=$freeDMRHost/" "$file_path"

    # 这个修改在匹配时允许了更多的空白字符，包括空格和制表符。[[:space:]]* 表示匹配零个或多个空白字符。这样就可以适应一些可能存在的额外空格或缩进，从而确保替换的准确性。不会成功！
    # sed -i "s/\[DMR Network 2\][[:space:]]*\nEnabled=1[[:space:]]*\nAddress=.*/[DMR Network 2]\nEnabled=1\nAddress=$freeDMRHost/" "$file_path"

    # 换 无效
    # sed -i "/\[DMR Network 2\]/,/\[/ {/Enabled=1/ s/Address=.*/Address=$freeDMRHost/}" "$file_path"
    
    # 无效
    # sed -i "/\[DMR\ Network\ 2\]/,/Address=192.168.2.33/ {/Enabled=1/ s/Address=.*/Address=$freeDMRHost/}" "$file_path"

    # 暂时用这个吧
    sed -i "/\[DMR Network 2\]/,/Address=192.168.2.33/ s/Address=192.168.2.33/Address=$freeDMRHost/" "$file_path"

    # 显示文件内容
    echo "文件 $file_path 的内容："
    cat "$file_path"
else
    echo "文件 $file_path 不存在"
fi

systemctl restart dmrgateway

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
echo "Name=FreeDMR_China9"
echo '#Simplex Mode,Static TG'
echo 'Options="TS2=460755;TIMER=15"'
echo '#Duplex mode'
echo 'Options="TS1=46001;TS2=460755;DIAL=0;TIMER=10;"'
