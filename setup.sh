#!/bin/bash

echo "[1/6] - check if cron is installed"

OS=0

if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$NAME
fi

which crontab &> /dev/null
if [ $? -ne 0 ]; then
  echo "cron package not found, installing..."
  if [ $OS == "Arch Linux" ];then
    echo "Arch Linux OS detected"
    sudo pacman -S cronie
  else
    echo "blw isn't currently implemented for your OS"
    echo "you can try to install cron from the CLI directly or modify this script"
  fi
else
  echo "cron package found"
fi

echo "[2/6] - check if cron service is started"

systemctl is-active cronie.service &> /dev/null
if [ $? -ne 0 ];then
  echo "cron service not started, starting it..."
  systemctl start cronie.service
fi

echo "cron service started"

echo "[3/6] - enable cron service"
systemctl is-enabled cronie.service &>/dev/null
if [ $? -ne 0 ];then
  echo "cron service not enabled, enabling it..."
  systemctl enable cronie.service
fi
echo "cron service enabled"

echo "[4/6] - add blw cron to crontab"

path=$(pwd)
(crontab -l 2>/dev/null; echo "* * * * * $(pwd)/blw.sh $(pwd) >> /tmp/blw.log 2>&1") | crontab -

echo "[5/6] - build the blw program"
make
echo "blw program built"

echo "[6/6] - configure window manager (i3/sway)"

if command -v sway &> /dev/null && [ -f "$HOME/.config/sway/config" ]; then
  CONFIG_FILE="$HOME/.config/sway/config"
  WM="sway"
elif command -v i3 &> /dev/null && [ -f "$HOME/.config/i3/config" ]; then
  CONFIG_FILE="$HOME/.config/i3/config"
  WM="i3"
else
  echo "neither i3 nor sway config found, skipping window manager configuration"
  CONFIG_FILE=""
fi

if [ -n "$CONFIG_FILE" ]; then
  if ! grep -q "BATTERY LEVEL WARNER" "$CONFIG_FILE"; then
    echo "adding window rule to $WM config..."
    echo "" >> "$CONFIG_FILE"
    echo 'for_window [title="BATTERY LEVEL WARNER"] floating enable, focus, sticky enable' >> "$CONFIG_FILE"
    echo "window rule added. You'll need to reload $WM for changes to take effect."
  else
    echo "window rule already exists in $WM config"
  fi
fi

echo "everything setted up"
