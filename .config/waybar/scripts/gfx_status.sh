#!/bin/bash
current=$(supergfxctl -g 2>/dev/null || echo "unknown")
case "$current" in
  Hybrid)
    icon="🖵"; label="Hybrid"; class="hybrid"; next="Integrated" ;;
  Integrated)
    icon="💾"; label="iGPU"; class="integrated"; next="Hybrid" ;;
  *)
    icon="❔"; label="$current"; class="unknown"; next="Hybrid" ;;
esac
printf '{"text":"%s %s","class":"%s","tooltip":"GPU: %s | Click to switch to %s"}\n' "$icon" "$label" "$class" "$current" "$next"
