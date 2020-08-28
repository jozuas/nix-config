#!/usr/bin/env bash

source /home/juozas/nix-config/variables.env

bash ~/.screenlayout/big.sh
feh --bg-fill ${BACKGROUND_PATH}
bash ~/scripts/polybar/launch.sh
