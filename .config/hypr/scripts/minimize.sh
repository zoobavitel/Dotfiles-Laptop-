#!/bin/bash
# Hyprland 0.57 (Lua): send the active window to the hidden special workspace.
hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:special", follow = false })'
