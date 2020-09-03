#!/usr/bin/env bash

# Script that pipes the current brightness level
# to the /tmp/xob-light-pipe for xob to consume

printf "%.*f\n" "0" "$(brillo -G)" > /tmp/xob-light-pipe
