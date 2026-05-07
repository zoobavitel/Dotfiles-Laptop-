#!/bin/bash

current=$(supergfxctl -g 2>/dev/null)
if [ "$current" = "Hybrid" ]; then
  supergfxctl --mode Integrated
else
  supergfxctl --mode Hybrid
fi
