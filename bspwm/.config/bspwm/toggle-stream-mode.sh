#!/bin/sh

# 440 is based on turning an ultrawide (3440) into 16:9
if [[ $(bspc config -m DP-2 left_padding) -eq 0 ]]; then
  bspc config -m DP-2 left_padding 440
  bspc config -m DP-2 right_padding 440
else
  bspc config -m DP-2 left_padding 0
  bspc config -m DP-2 right_padding 0
fi
