#!/bin/bash
# Wait for Hyprland socket to be available
sleep 2

# Balanced on battery — Quiet was too aggressive on this 8GB G14.
asusctl profile set Balanced
hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1, vrr = 0 })'

notify-send "Battery Mode" "60Hz + Balanced (hybrid GPU)."
