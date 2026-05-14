#!/bin/bash

asusctl_mode=$(asusctl profile get 2>/dev/null | grep -i "Active profile" | awk -F': ' '{print $2}' | xargs)

case "$asusctl_mode" in
  Quiet)
    icon="🔈"
    label="Quiet"
    class="quiet"
    next_profile="Balanced"
    ;;
  Balanced)
    icon="🖥"
    label="Balanced"
    class="balanced"
    next_profile="Performance"
    ;;
  Performance)
    icon="⚡"
    label="Turbo"
    class="performance"
    next_profile="Quiet"
    ;;
  *)
    icon="❔"
    label="N/A"
    class="unknown"
    next_profile="Quiet"
    ;;
 esac

printf '{"text":"%s %s","class":"%s","tooltip":"ASUS profile: %s | Click to switch to %s"}\n' \
  "$icon" "$label" "$class" "$label" "$next_profile"
