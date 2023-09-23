#!/usr/bin/env bash

# Inverts the colours of the currently active window with picom

if [ "$(pidof picom)" ]; then
  pkill picom
else
  ID=$(xdotool getactivewindow)
  COND="client=${ID}"
  picom --invert-color-include "$COND" -b
fi
