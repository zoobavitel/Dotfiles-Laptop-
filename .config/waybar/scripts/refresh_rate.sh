#!/bin/bash
RATE=$(hyprctl monitors -j | jq -r '.[] | select(.name == "eDP-1") | .refreshRate' | cut -d. -f1)
echo "{\"text\": \"⟳ ${RATE}Hz\", \"class\": \"refresh\"}"
