#!/bin/bash
sleep 2

asusctl profile set Performance
hyprctl keyword monitor eDP-1,1920x1080@144,0x0,1,vrr,1

notify-send "AC Mode" "144Hz + Performance (hybrid GPU)."
