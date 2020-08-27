#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

function launch() {
  echo "--- $(date) ---" | tee -a /tmp/polybar.log

  if [ "$#" -eq 1 ]; then
    MONITOR=$1 polybar --log=error bar >>/tmp/polybar.log 2>&1 &
  else
    polybar --log=error bar >>/tmp/polybar.log 2>&1 &
  fi
}

# Launch for every connected monitor
if type "xrandr"; then
  for monitor in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    launch "$monitor"
  done
else
  launch
fi
