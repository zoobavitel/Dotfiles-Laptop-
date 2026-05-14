#!/bin/bash
current=$(supergfxctl -g 2>/dev/null)

if [ "$current" = "Hybrid" ]; then
  target="Integrated"
else
  target="Hybrid"
fi

supergfxctl --mode "$target"
notify-send "GPU Mode" "Switching to $target — logging out" -u critical -t 2000
sleep 2
hyprctl dispatch exit