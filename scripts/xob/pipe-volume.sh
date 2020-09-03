#!/usr/bin/env bash

# Script that pipes the current volume level
# to the /tmp/xob-volume-pipe for xob to consume

volume=$(pamixer --get-volume)
mute_status=$(pamixer --get-mute)

if [ "$mute_status" == "true" ]; then
  volume="$volume!"
fi

echo "$volume" > /tmp/xob-volume-pipe
