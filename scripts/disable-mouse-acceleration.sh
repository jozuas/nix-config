#!/usr/bin/env bash

xinput

read -rp "Device ID: " device_id

xinput --set-prop "$device_id" "libinput Accel Speed" -1
