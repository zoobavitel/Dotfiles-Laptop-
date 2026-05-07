#!/bin/bash

current_mode=$(supergfxctl -g 2>/dev/null || echo "unknown")

case "$current_mode" in
  Hybrid)
    icon="🖵"
    label="Hybrid"
    class="hybrid"
    next_mode="Integrated"
    ;;
  Integrated)
    icon="💾"
    label="iGPU"
    class="integrated"
    next_mode="Hybrid"
    ;;
  AsusMuxDgpu|Dedicated|Vfio|Compute)
    icon="⚙"
    label="$current_mode"
    class="dedicated"
    next_mode="Hybrid"
    ;;
  *)
    icon="❔"
    label="$current_mode"
    class="unknown"
    next_mode="Hybrid"
    ;;
 esac

printf '{"text":"%s %s","class":"%s","tooltip":"GPU mode: %s | Click to switch to %s"}\n' \
  "$icon" "$label" "$class" "$current_mode" "$next_mode"
