#!/bin/bash

# Get the name of the focused monitor (search backward from "focused: yes")
focused_monitor=$(hyprctl monitors | awk '
  $1 == "Monitor" { mon = $2 }
  /focused: yes/ { print mon; exit }
')

# Get its refresh rate from the next line
refresh=$(hyprctl monitors | awk -v mon="$focused_monitor" '
  $1 == "Monitor" && $2 == mon {
    getline
    if (match($0, /@([0-9.]+)/, m)) {
      printf("%.0f", m[1])
      exit
    }
  }
')

# Fallback
[ -z "$refresh" ] && refresh="?"

echo "{\"text\": \"📺 ${refresh}Hz\"}"



