#!/bin/bash

current_mode=$(supergfxctl -g 2>/dev/null || echo "unknown")

case "$current_mode" in
  Hybrid)
    icon="🖵"
    label="Hybrid"
    class="hybrid"
    ;;
  Integrated)
    icon="💾"
    label="iGPU"
    class="integrated"
    ;;
  AsusMuxDgpu|Dedicated|Vfio|Compute)
    icon="⚙"
    label="$current_mode"
    class="dedicated"
    ;;
  *)
    icon="❔"
    label="$current_mode"
    class="unknown"
    ;;
esac

printf '{"text":"%s %s","class":"%s","tooltip":"GPU mode: %s"}\n' \
  "$icon" "$label" "$class" "$current_mode"
