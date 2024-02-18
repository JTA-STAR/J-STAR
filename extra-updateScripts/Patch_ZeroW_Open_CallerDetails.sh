#!/bin/bash
# Add_BPiM2_HDMI_Chrome_AutoStart
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_ZeroW_Open_CallerDetails.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw /

sudo touch /tmp/tmpUpdatePath.log; 
sudo chmod 777 /tmp/tmpUpdatePath.log; 

autostartConfig="/etc/pistar-release";
FIND_STR="ProcNum"
#If NOT exist , add it
if [ `grep -c "$FIND_STR" $autostartConfig` -ne '0' ];then
    echo "Char ${FIND_STR} exist "
else
    echo "Char ${FIND_STR} NOT exist ,and this Attribute/Segment "
    echo "ProcNum = 1" >> ${autostartConfig}  
fi

#If ZeroW 1 core, crack it to 4 core
if [ -f ${autostartConfig} ]; then
	sudo sed -i "s#\<ProcNum\ =\ 1\>#ProcNum\ =\ 4#g" ${autostartConfig}  
	cat ${autostartConfig}
fi
 
echo "完成，刷新生效！Done, refresh to use " 