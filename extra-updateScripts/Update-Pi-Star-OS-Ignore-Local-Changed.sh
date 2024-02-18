#!/bin/bash
#
###############################################################################
#                                                                             
#                     How to run this script?                               
#                     http://pi-star:4200                                    
#                     https://pi-star:4200                                    
#          Mourse right click Copy and Paste
# curl -Ls https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Update-Pi-Star-OS-Ignore-Local-Changed.sh | sudo bash
#
#                            by @BI7JTA                                       
#                                                                             
###############################################################################
#
if [ "$(id -u)" != "0" ]; then
  echo -e "You need to be root to run this command...\n"
  exit 1
fi

TICK="[✓]"
INFO="[i]"

mount -o remount,rw / # for shits and giggles


git_update() {
	# Set the function variables
	gitFolder=${1}
	# get proper W0CHP dash branch user is running...
	dash_branch="$( git --git-dir=${gitFolder}/.git branch | grep '*' | awk {'print $2'} )"

  #Git-忽略冲突，强制更新代码并覆盖本地代码
  git --work-tree=${gitFolder} --git-dir=${gitFolder}/.git reset --hard && git --work-tree=${gitFolder} --git-dir=${gitFolder}/.git clean -f #使本地完全回退到上次 commit
  git --work-tree=${gitFolder} --git-dir=${gitFolder}/.git fetch --all
  # Reset local modified,
  git --work-tree=${gitFolder} --git-dir=${gitFolder}/.git reset --hard origin/master
  # Pull new updated,
  git --work-tree=${gitFolder} --git-dir=${gitFolder}/.git pull -q origin master 
}

main_function() {

	# Make the disk writable and stop cron to prevent it from making it R/O
    	systemctl stop cron.service > /dev/null 2<&1
    	pkill pistar-hourly.cron > /dev/null 2>&1
    	pkill pistar-daily.cron > /dev/null 2>&1
 

	echo "Stopping Services..."
	pistar-services fullstop > /dev/null 2>&1
	echo -e "${TICK} Done!\n"

	# ensure FS is RW
	touch /root/.WPSD-updating > /dev/null 2>&1
	if [ ! -f /root/.WPSD-updating ] ; then
	    touch /root/.WPSD-updating > /dev/null 2>&1
	    if [ ! -f /root/.WPSD-updating ] ; then
		echo -e "Filesystem could not enter R/W mode...please try updating again.\n"
		exit 1
	    fi
	fi

	echo "Updating W0CHP-PiStar-Dash Scripts and Support Programs..."
	git_update /usr/local/sbin
	#systemctl daemon-reload > /dev/null 2>&1
	echo -e "${TICK} Done!\n"

	echo "Updating W0CHP-PiStar-Dash Digital Voice and Related Binaries..."
	git_update /usr/local/bin
	echo -e "${TICK} Done!\n"

	echo "Updating W0CHP-PiStar-Dash Web Dashboard Software..."
	git_update /var/www/dashboard
	echo -e "${TICK} Done!\n"
 
 
	echo "Starting Services..."
	pistar-services start > /dev/null 2>&1
	echo -e "${TICK} Done!\n"
	
	echo "Updates complete, syncing disk cache..."
	rm /root/.WPSD-updating > /dev/null 2>&1
	/bin/sync
	/bin/sync
	/bin/sync
	systemctl start cron.service > /dev/null 2<&1
	echo -e "${TICK} Update Process Finished!"
	
  echo "update done! "
}

	if [ -t 1 ]; then
 		# run via terminal, only output to screen
 		main_function
	else
 		# if not run via terminal, log everything into a log file
 		# echo "Execute /usr/local/sbin/Update-Pi-Star-OS-Ignore-Local-Changed.sh" >> /var/log/pi-star/pi-star_update.log 2>&1
 		main_function #>> /var/log/pi-star/pi-star_update.log 2>&1
	fi
 

exit 0