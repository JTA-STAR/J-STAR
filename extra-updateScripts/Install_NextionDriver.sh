#!/bin/bash

## sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Install_NextionDriver.sh | sudo sh

main_function() {

	service_file="/lib/systemd/system/nextiondriver.service"

	# 检查文件是否存在
	if [ -f "$service_file" ]; then
	    echo "错误: 监测到已安装NextionDriver驱动, 请先执行先卸载."
	    exit 1
	fi
	 
	sudo mount -o remount,rw /
	sudo systemctl stop nextiondriver;
	sudo systemctl disable nextiondriver;
	sudo systemctl unmask nextiondriver;
	sudo rm /usr/local/bin/NextionDriver;
	sudo rm /etc/mmdvmhost.old;

	file_path="/etc/mmdvmhost"

	sudo sed -i "s#\[NextionDriver\]#\[DelNextionDriver\]#g" "$file_path"
	# 替换 Display 行
	sed -i 's/^Display=.*/Display=Nextion/' "$file_path"

	# 替换 [Nextion] 部分的 Port 行
	sed -i '/\[Nextion\]/,/^$/s/^Port=None/Port=modem/' "$file_path"

	cat "$file_path"

	cd /home/pi-star; 
	curl -Ls https://www.bi7jta.cn/files/MMDVM_Nextion/Driver/oneKey_install_NextionDriver_CN.sh | sudo bash
	echo "完成！"
 }
 
 if [ -t 1 ]; then
 	# run via terminal, only output to screen
 	main_function
else
 	# if not run via terminal, log everything into a log file
 	main_function >> /var/log/pi-star/InstallNextionDriver.log 2>&1
fi

