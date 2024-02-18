#!/bin/bash
#  
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Set_EN_LanguageAndTimeZone.sh | sudo sh

# Remount root as writable
sudo mount -o remount,rw /

sudo touch /tmp/tmpUpdatePath.log; 
sudo chmod 777 /tmp/tmpUpdatePath.log; 

languageConfig="/var/www/dashboard/config/language.php";
if [ -f ${languageConfig} ]; then 
	sudo sed -i "/\$pistarLanguage=/d" ${languageConfig} 
	# Add English Language
    sudo sed -i "/include_once/ i\$pistarLanguage=\'english_us\';" ${languageConfig} 
	cat ${languageConfig}
fi
 
echo "完成，刷新生效！Done, refresh to use " 