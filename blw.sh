#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=$HOME/.Xauthority

PROG_PATH=$1

STATE_FILE_20="$PROG_PATH/status_file20"
STATE_FILE_10="$PROG_PATH/status_file10"
STATE_FILE_5="$PROG_PATH/status_file5"

BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)


if [ $BATTERY_LEVEL -lt 20 ] && [ ! -f $STATE_FILE_20 ] && [ $BATTERY_STATUS == "Discharging" ];then
  cd $PROG_PATH
  ./build/blw 20
  touch $STATE_FILE_20
fi

if [ $BATTERY_LEVEL -lt 10 ] && [ ! -f $STATE_FILE_10 ] && [ $BATTERY_STATUS == "Discharging" ];then
  cd $PROG_PATH
  ./build/blw 10
  touch $STATE_FILE_10
fi

if [ $BATTERY_LEVEL -lt 5 ] && [ ! -f $STATE_FILE_5 ] && [ $BATTERY_STATUS == "Discharging" ];then
  cd $PROG_PATH
  ./build/blw 5
  touch $STATE_FILE_5
fi

if [ $BATTERY_STATUS == "Charging" ];then
  rm $STATE_FILE_20 &>/dev/null
  rm $STATE_FILE_10 &>/dev/null
  rm $STATE_FILE_5 &>/dev/null
fi
