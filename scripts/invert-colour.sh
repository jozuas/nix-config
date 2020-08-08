#!/usr/bin/env bash

# Inverts the colours of the currently active window with picom

if [ "$(pidof picom)" ]; then
  pkill picom
else
  ID=$(xdotool getactivewindow)
  CLASS=$(xprop -id "$ID" | grep "WM_CLASS" | awk '{print $4}')
  COND="client=${ID}"
  picom --experimental-backends --invert-color-include "$COND" -b
fi
