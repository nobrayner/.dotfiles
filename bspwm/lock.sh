#!/usr/bin/env bash
ssh-add -D

pkill i3lock

i3lock -n \
    --ignore-empty-password \
    --color=00000044 \
    --insidever-color=00000000 \
    --insidewrong-color=00000000 \
    --inside-color=00000000 \
    --ringver-color=a3be8cff \
    --ringwrong-color=bf616aff \
    --ring-color=81a1c122 \
    --line-uses-inside \
    --keyhl-color=ebcb8bff \
    --bshl-color=bf616aff \
    --separator-color=00000000 \
    --force-clock \
    --time-str="%H:%M" \
    --time-size=192 \
    --time-pos="x+w/2:y+h/5" \
    --time-color=ffffffff \
    --date-str="%A, %B %d" \
    --date-size=36 \
    --date-pos="tx:ty+80" \
    --date-color=ffffffff \
    --verif-text="" \
    --wrong-text="" \
    --noinput-text="" \
    --indicator \
    --ind-pos="x+w/2:y+h/2" \
    --radius=256 \
    --ring-width=24
