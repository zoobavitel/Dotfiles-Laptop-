#!/bin/bash
addr=$(hyprctl activewindow -j | jq -r .address)
hyprctl dispatch movetoworkspacesilent special,address:$addr
