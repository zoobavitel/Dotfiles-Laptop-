#!/bin/bash

MONITOR="eDP-1"

# Get current refresh rate (returns something like 144.00000)
CURRENT=$(hyprctl monitors -j | jq -r '.[] | select(.name == "'"$MONITOR"'") | .refreshRate')

# Truncate to integer for comparison
RATE=${CURRENT%.*}

if [ "$RATE" -gt 100 ]; then
    hyprctl eval "hl.monitor({ output = \"$MONITOR\", mode = \"1920x1080@60\", position = \"0x0\", scale = 1, vrr = 1 })"
    notify-send "Display" "Refresh rate → 60Hz" -i video-display
else
    hyprctl eval "hl.monitor({ output = \"$MONITOR\", mode = \"1920x1080@144\", position = \"0x0\", scale = 1, vrr = 1 })"
    notify-send "Display" "Refresh rate → 144Hz" -i video-display
fi
