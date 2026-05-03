#!/bin/bash

MONITOR="eDP-1"

# Get current refresh rate (returns something like 144.00000)
CURRENT=$(hyprctl monitors -j | jq -r '.[] | select(.name == "'"$MONITOR"'") | .refreshRate')

# Truncate to integer for comparison
RATE=${CURRENT%.*}

if [ "$RATE" -gt 100 ]; then
    hyprctl keyword monitor "$MONITOR,1920x1080@60,0x0,1,vrr,1"
    notify-send "Display" "Refresh rate → 60Hz" -i video-display
else
    hyprctl keyword monitor "$MONITOR,1920x1080@144,0x0,1,vrr,1"
    notify-send "Display" "Refresh rate → 144Hz" -i video-display
fi
