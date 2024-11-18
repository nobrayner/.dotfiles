#!/bin/sh

# 880 is based on turning an ultrawide (3440) into 16:9, only using the left side
if [[ $(bspc config -m DP-0 right_padding) -eq 0 ]]; then
  bspc config -m DP-0 right_padding 880
else
  bspc config -m DP-0 right_padding 0
fi
