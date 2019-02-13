#!/bin/bash
#start net speeder
ETH=$(eval "ifconfig | grep 'eth0'| wc -l")
if [ "$ETH"  ==  '1' ] ; then
	nohup /usr/local/bin/net_speeder eth0 "ip" >/dev/null 2>&1 &
fi
if [ "$ETH"  ==  '0' ] ; then
    nohup /usr/local/bin/net_speeder venet0 "ip" >/dev/null 2>&1 &
fi
# SSH
/etc/init.d/ssh restart
# Config UUID
if [ -n "$UUID" ];then
  sed -i "s/UUID/$UUID/g" /etc/v2ray/config.json
  echo "You've set an UUID"
  echo "The UUID is: $UUID"
else
  export UUID=$(cat /proc/sys/kernel/random/uuid)
  # UUID=$(v2ctl uuid)
  sed -i "s/UUID/$UUID/g" /etc/v2ray/config.json
  echo "UUID is set $UUID"
fi
# Config TGKEY
if [ -n "$TGKEY" ];then
  sed -i "s/TGKEY/$TGKEY/g" /etc/v2ray/config.json
  echo "You've set an TGKEY"
  echo "The TGKEY is: $TGKEY"
else
  export TGKEY=$(openssl rand -hex 16)
  sed -i "s/TGKEY/$TGKEY/g" /etc/v2ray/config.json
  echo "TGKEY is set $TGKEY"
fi
# service bt restart
/usr/bin/supervisord -c /etc/supervisord.conf
exec "$@"
