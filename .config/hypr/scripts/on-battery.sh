#!/bin/bash
# Wait for Hyprland socket to be available
sleep 2

# Balanced on battery — Quiet was too aggressive on this 8GB G14.
asusctl profile set Balanced
hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1,vrr,0

notify-send "Battery Mode" "60Hz + Balanced (hybrid GPU)."
