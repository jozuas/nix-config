#!/usr/bin/env bash

polybar_config=~/.config/polybar/config

if grep -q ";tray-position" $polybar_config; then
  sed -i 's/;tray-position\ =\ right/tray-position\ =\ right/' $polybar_config
else
  sed -i 's/tray-position\ =\ right/;tray-position\ =\ right/' $polybar_config
fi

bash ~/.nix-config/scripts/polybar/launch.sh
