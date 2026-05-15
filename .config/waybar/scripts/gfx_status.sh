#!/bin/bash
status=$(cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status 2>/dev/null || echo "unknown")
case "$status" in
  active)
    icon="🖵"; label="dGPU on"; class="hybrid" ;;
  suspended)
    icon="💾"; label="dGPU off"; class="integrated" ;;
  *)
    icon="❔"; label="$status"; class="unknown" ;;
esac
printf '{"text":"%s %s","class":"%s","tooltip":"dGPU power: %s"}\n' "$icon" "$label" "$class" "$status"
