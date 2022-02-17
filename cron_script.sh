TH="`dirname \"$0\"`"              # relative
LOG_PATH="`( cd \"$MY_PATH\" && cd .. && pwd )`/pi/log/network.log"
now=$(date +"%m-%d %r")

# Which Interface do you want to check
wlan='wlan0'
# Which address do you want to ping to see if you can connect
pingip='google.com'

# Performing network check
/bin/ping -c 2 -I $wlan $pingip > /dev/null 2> /dev/null
while [ $? -ge 1 ];
do
    echo "$now : Network is DOWN Retrying" >> $LOG_PATH
    /sbin/ifdown $wlan
    sleep 5
    /sbin/ifup --force $wlan
    /bin/ping -c 2 -I $wlan $pingip > /dev/null 2> /dev/null
done
echo "$now : Connection Successful" >> $LOG_PATH
