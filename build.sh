#!/bin/bash

echo "[1/5] - check if cron is installed"

which crontab &> /dev/null
if [ $? -ne 0 ]; then
  echo "cron package not found, installing..."
  sudo pacman -S cronie
else
  echo "cron package found"
fi

echo "[2/5] - check if cron service is started"

systemctl is-active cronie.service &> /dev/null
if [ $? -ne 0 ];then
  echo "cron service not started, starting it..."
  systemctl start cronie.service
fi

echo "cron service started"

echo "[3/5] - enable cron service"
systemctl is-enabled cronie.service &>/dev/null
if [ $? -ne 0 ];then
  echo "cron service not enabled, enabling it..."
  systemctl enable cronie.service
fi
echo "cron service enabled"

echo "[4/5] - add blw cron to crontab"

path=$(pwd)
(crontab -l 2>/dev/null; echo "* * * * * $(pwd)/blw.sh $(pwd) >> /tmp/blw.log 2>&1") | crontab -

echo "[5/5] - build the blw program"
make &>/dev/null
echo "blw program built"

echo "everything setted up"
