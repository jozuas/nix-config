#!/usr/bin/env bash

volume_pipe=/tmp/xob-volume-pipe
light_pipe=/tmp/xob-light-pipe
config=/home/juozas/nix-config/dotfiles/xob.cfg

echo "Script has been called" >>/tmp/xob.log

if [ ! -f $volume_pipe ]; then
  echo "Creating volume pipe" >>/tmp/xob.log
  mkfifo $volume_pipe
fi
if [ ! -f $light_pipe ]; then
  echo "Creating light pipe" >>/tmp/xob.log
  mkfifo $light_pipe
fi

# Terminate already running xob instances
pkill xob

echo "--- $(date) ---" | tee -a /tmp/xob.log
tail -f $volume_pipe | xob -c $config >>/tmp/xob.log 2>&1 &
tail -f $light_pipe | xob -c $config >>/tmp/xob.log 2>&1 &
