#!/usr/bin/env bash

playerctl -p chromium status 2> /dev/null | grep -c -q "Playing"

if [ "$?" -eq 0 ]; then
  echo "$(playerctl -p chromium metadata title | sed "s/^\(.\{50\}\).*$/\1/") - $(playerctl -p chromium metadata artist)"
else
  echo "-"
fi
