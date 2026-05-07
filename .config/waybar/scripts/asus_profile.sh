#!/bin/bash

asusctl_mode=$(asusctl profile --profile-get 2>/dev/null | grep -i "Active profile" | awk -F'is ' '{print $2}' | xargs)

case "$asusctl_mode" in
  Quiet)
    icon="🔈"
    label="Quiet"
    class="quiet"
    ;;
  Balanced)
    icon="🖥"
    label="Balanced"
    class="balanced"
    ;;
  Performance)
    icon="⚡"
    label="Turbo"
    class="performance"
    ;;
  *)
    icon="❔"
    label="N/A"
    class="unknown"
    ;;
 esac

printf '{"text":"%s %s","class":"%s","tooltip":"ASUS profile: %s"}\n' \
  "$icon" "$label" "$class" "$label"
