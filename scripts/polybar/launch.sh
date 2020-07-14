#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Launch
echo "--- $(date) ---" | tee -a /tmp/polybar.log
polybar --log=error bar >>/tmp/polybar.log 2>&1 &
