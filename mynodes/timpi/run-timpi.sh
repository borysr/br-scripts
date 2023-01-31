#!/bin/sh
cd /home/borysr/TimpiCollector/; 
. $HOME/.profile; 

echo "==== run-timpi.sh started = $(date) ="

while (true)
do
  if [ "$(pgrep TimpiCollector)" != "" ]
  then
    echo "TimpiCollector is already running $(date)"
  else
    echo "Staring TimpioCollector $(date)"
    ./TimpiCollector >> timpi.log 2>&1 &
  fi
  sleep  120
done

