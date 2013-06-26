#!/system/bin/sh

# setup 'net.hostname' which is needed for dhcpc in libnetutils.so works properly.

if [ -z "`getprop net.hostname`" ]; then

serial_number=`getprop ro.serialno`
[ -n "${serial_number}" ] && { setprop net.hostname klaatu-${serial_number}; exit 0; }

serial_number=`netcfg | grep ifb0 | awk -F " " '{print $5}' | sed s'/://g'`
[ -n "${serial_number}" ] && { setprop net.hostname klaatu-${serial_number}; exit 0; }

serial_number=`netcfg | grep wlan0 | awk -F " " '{print $5}' | sed s'/://g'`
[ -n "${serial_number}" ] && { setprop net.hostname klaatu-${serial_number}; exit 0; }

serial_number=`netcfg | grep eth0 | awk -F " " '{print $5}' | sed s'/://g'`
[ -n "${serial_number}" ] && { setprop net.hostname klaatu-${serial_number}; exit 0; }

[ -z "${serial_number}" ] && { setprop net.hostname klaatu-dummy; exit 0; }

fi
