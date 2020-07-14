#!/usr/bin/env bash

device_id=$(xinput | sed '/[tT]ouch[pP]ad/s/.*id=\([0-9]*\).*/\1/;t;d')
is_enabled=$(xinput list-props "$device_id" | grep "Device Enabled" | grep -o "[01]$")

if [ $is_enabled == "1" ]; then
	xinput set-prop $device_id "Device Enabled" 0
else
	xinput set-prop $device_id "Device Enabled" 1
fi
