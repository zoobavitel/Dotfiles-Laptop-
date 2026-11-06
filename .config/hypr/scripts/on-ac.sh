#!/bin/bash
sleep 2

asusctl profile set Performance
hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@144", position = "0x0", scale = 1, vrr = 1 })'

notify-send "AC Mode" "144Hz + Performance (hybrid GPU)."
