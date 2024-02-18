#!/bin/bash
# Add to J-STAR-OS-Patch_Fix_v2.3_rustdesk_same-ID-issue
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/J-STAR-OS-Patch_Fix_v2.3_rustdesk_same-ID-issue.sh | sudo sh

# /root/.config/rustdesk/RustDesk.toml
# 00L9BsUysRGj3y2N7W/5SFgx4s/AFQr/rxAQ==  #RPi4B 解码后是原始字符串 492331739
# 00KHz/FNu4rghAOgAOYtxmgNTAlj2sxrEQEQ==  #RPi5B Bookworm
# 00LySziUa1ulpT+59cxMr4rQ1nRCj5ycXGFQ==  #2W
# 00eTOZDvXNIjLVzQk+GD3O9sRWjMviUDX+      #BPiM2
# 00TdXPIQnmd4uCwl5WZqDy7sBSis/iVzL8RA==  #M2z
# 00lbfdli4cmIdM8ZGezUW3ewAjeVqe5zH/rQ==  #X86_64

config_file="/root/.config/rustdesk/RustDesk.toml"
id_strings="00lbfdli4cmIdM8ZGezUW3ewAjeVqe5zH/rQ== 00L9BsUysRGj3y2N7W/5SFgx4s/AFQr/rxAQ== 00KHz/FNu4rghAOgAOYtxmgNTAlj2sxrEQEQ== 00LySziUa1ulpT+59cxMr4rQ1nRCj5ycXGFQ== 00eTOZDvXNIjLVzQk+GD3O9sRWjMviUDX+ 00TdXPIQnmd4uCwl5WZqDy7sBSis/iVzL8RA=="
if [ -f "$config_file" ]; then
    # 文件存在
    contains_string=false
    for id_string in $id_strings; do
        if grep -qF "$id_string" "$config_file"; then
            contains_string=true
            break
        fi
    done

    if $contains_string; then
        # 文件包含指定字符串
        cat "$config_file"
        echo "Detect the RustDesk default ID, delete and let the OS generate new ID." 

        # Remount root as writable
		sudo mount -o remount,rw / 
		 
		# I guess you will NOT success use the default ID, so I not restart ruster service 
		#systemctl stop rustdesk.service

		rm -f /root/.config/rustdesk/* 
		rm -f /home/repeater/.config/rustdesk/*
		rm -f /home/pi-star/.config/rustdesk/*
		rm -f /home/pi/.config/rustdesk/*
		#rm -f /etc/machine-id

		#systemctl start rustdesk.service
    else
        # 文件不包含指定字符串
        cat "$config_file"
        echo "Not detect the RustDesk use default ID, skip it."
    fi 
else
    # 文件不存在
    echo "RustDesk config file $config_file not exist, skip it."
fi

# 显示文件内容
echo "All done, you you can re-open your RustDesk in J-STAR Desktop"

 
