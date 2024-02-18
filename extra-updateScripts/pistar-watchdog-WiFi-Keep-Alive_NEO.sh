###
 # @Author: BI7JTA
 # @Date: 2023-10-16 15:53:34
 # @LastEditTime: 2023-10-16 15:53:34
 # @LastEditors: Please set LastEditors
 # @Description: Solve BPiM2 betty  dhd_prot_ioctl : bus is down. we have nothing to do
 # @ScriptPath: /home/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.sh
 # @FilePath: /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log
 # @TODO: add to service , instead of /etc/rc.local
### 
#!/bin/sh 
mkdir -p /var/log/pi-star/
while true
do
    CURTIME=`date "+%Y-%m-%d %H:%M:%S"`
    echo "$CURTIME: call WiFi auto Down watchdog, loop after 60s " >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log

    
    if [ -d "/sys/class/net/wlan0" ]; then	   
	echo "DEBUG: check /sys/class/net/wlan0 exist " >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log
	echo "DEBUG: cat /sys/class/net/wlan0/operstate  " >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log
	cat /sys/class/net/wlan0/operstate >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log
    else
	echo "DEBUG: /sys/class/net/wlan0 NOT exist"  >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log
    fi

    if [ -d "/sys/class/net/wlan0_ap" ]; then
	echo "DEBUG: check /sys/class/net/wlan0_ap exist"  >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log
    else
	echo "DEBUG: check /sys/class/net/wlan0_ap NOT exist"  >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log
    fi

    #Solve BPiM2 betty  dhd_prot_ioctl : bus is down. we have nothing to do
    if [ -d "/sys/class/net/wlan0" ] && [ ! -d "/sys/class/net/wlan0_ap" ]; then
        echo "DEBUG: /sys/class/net/wlan0 exist and /sys/class/net/wlan0_ap NOT exist"  >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log 
        #if [ `cat /sys/class/net/wlan0/operstate` == "down" ]; then
        #NOTE: If work in nohup and in /etc/rc.local call, can use this adjustment, it will never got "Down"
        if [ `grep -c "down" /sys/class/net/wlan0/operstate` -ne '0' ];then
        echo "$CURTIME: find WLAN0 down and not in AP mode,  call ip link set wlan0 up " >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log
        ip link set wlan0 up
       else
        echo "DEBUG: something check error, Code:002"  >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log 
       fi
    else
       echo "DEBUG: something check error, Code:001"  >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive_NEO.log 
    fi
 sleep 60 
 
done
