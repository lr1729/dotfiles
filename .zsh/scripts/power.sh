#!/usr/bin/bash

# Reference: https://bbs.archlinux.org/viewtopic.php?id=207186

STATE=""
BAT="BAT0"

if [[ "$1" == "BAT" || "$1" == "AC" ]]; then
  STATE="$1"
fi

if [[ $STATE == "" ]]; then
  if [[ $(upower -i /org/freedesktop/UPower/devices/battery_$BAT | grep state | grep discharging) == "" ]]; then
    STATE="AC"
  else STATE="BAT"
  fi
fi

echo $STATE

if [[ $STATE == "BAT" ]]; then
  echo "Discharging, set governor to ondemand"
  cpupower frequency-set -g ondemand
  runuser -l ling -c 'XDG_RUNTIME_DIR=/run/user/$UID systemctl --user stop conky.service'
elif [[ $STATE == "AC"  ]]; then
  echo "AC plugged in, set governor to performance"
  cpupower frequency-set -g performance
  runuser -l ling -c 'XDG_RUNTIME_DIR=/run/user/$UID systemctl --user start conky.service'
fi
