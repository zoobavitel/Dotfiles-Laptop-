#!/bin/bash
# Returns non-zero if no minimized windows — waybar hides the module
COUNT=$(hyprctl clients -j | jq '[.[] | select(.workspace.name == "special:special")] | length')
[ "$COUNT" -gt 0 ]
