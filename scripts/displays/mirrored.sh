#!/usr/bin/env bash

xrandr --output eDP-1 --rate 60 --mode 1920x1080 --fb 1920x1080 --panning 1920x1080* --output DP-1 --mode 1920x1080 --same-as eDP-1
bash ~/scripts/polybar/launch.sh
bash ~/scripts/xob/launch.sh
