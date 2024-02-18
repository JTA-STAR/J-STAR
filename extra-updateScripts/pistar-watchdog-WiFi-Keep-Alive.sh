###
 # @Author: BI7JTA
 # @Date: 2023-10-16 15:53:34
 # @LastEditTime: 2023-10-16 15:53:34
 # @LastEditors: Please set LastEditors
 # @Description: Solve BPiM2 betty  dhd_prot_ioctl : bus is down. we have nothing to do
 # @ScriptPath: /usr/local/sbin/pistar-watchdog-WiFi-Keep-Alive.sh
 # @FilePath: /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive.log
 # @TODO: add to service , instead of /etc/rc.local
### 
#!/bin/sh 
mkdir -p /var/log/pi-star/
while true
do
    CURTIME=`date "+%Y-%m-%d %H:%M:%S"`
    echo "$CURTIME: call WiFi auto Down watchdog, loop after 60s " >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive.log
    #Solve BPiM2 betty  dhd_prot_ioctl : bus is down. we have nothing to do
    if [ -d "/sys/class/net/wlan0" ] && [ ! -d "/sys/class/net/wlan0_ap" ]; then
      if [ `cat /sys/class/net/wlan0/operstate` == "down" ]; then
        echo "$CURTIME: find WLAN0 down and not in AP mode,  call ip link set wlan0 up " >> /var/log/pi-star/pistar-watchdog-WiFi-Keep-Alive.log
        ip link set wlan0 up
      fi
    fi
 sleep 60 
 
done