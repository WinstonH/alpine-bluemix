#!/bin/sh
while [ 1 ]
do
  ps -fe|grep firefox |grep -v grep
  if [ $? -ne 0 ]
  then
  echo "start firefox ..."
  firefox http://www.ebesucher.com/surfbar/bjdhjj >/dev/null 2>&1 &
  else
  echo "firefox is running"
  fi
  sleep 30
 done
#####
