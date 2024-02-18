#!/bin/bash

## sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Remove_NextionDriver.sh | sudo sh

main_function() {
	mount -o remount,rw /
	systemctl stop dmrgateway.timer; 
	systemctl stop dmrgateway; 
	systemctl stop mmdvmhost; 
	systemctl stop nextiondriver; 
    sudo systemctl disable nextiondriver;
    sudo systemctl unmask nextiondriver;

	service_file="/lib/systemd/system/nextiondriver.service"

	# 检查文件是否存在
	if [ -f "$service_file" ]; then
	    echo "Delete file ${service_file} ."
        sudo rm ${service_file};
	fi

	rm /usr/local/bin/NextionDriver;
	sudo rm /etc/mmdvmhost.old;
	rm /etc/mmdvmhost.old;

    file_path=/etc/mmdvmhost
	# 多行替换 [Transparent Data] 部分的 Enable=1 为0
    sed -i '/\[Transparent Data\]/{:a;N;/Enable=1/!ba;s/Enable=1/Enable=0/}' "$file_path"
	sed -i '/\[Nextion\]/{:a;N;/Port=\/dev\/ttyNextionDriver/!ba;s/Port=\/dev\/ttyNextionDriver/Port=modem/}' "$file_path"
    cat /etc/mmdvmhost 
	
	# 清除残留
	sed -i "s#\[NextionDriver\]#\[DelNextionDriver\]#g" "$file_path"

	# 删除依赖
	sudo sed -i  "/nextiondriver/d" /lib/systemd/system/mmdvmhost.service; 
	systemctl daemon-reload; 
	systemctl start mmdvmhost; 
	systemctl start dmrgateway;
	systemctl start dmrgateway.timer; 

	cat /lib/systemd/system/mmdvmhost.service
	echo "Done Remove NextionDriver！"
	echo "卸载完成，如需重新安装，可以进入安装界面继续！"
 }

 if [ -t 1 ]; then
 	# run via terminal, only output to screen
 	main_function
else
 	# if not run via terminal, log everything into a log file
 	main_function >> /var/log/pi-star/UnInstallNextionDriver.log 2>&1
fi


 