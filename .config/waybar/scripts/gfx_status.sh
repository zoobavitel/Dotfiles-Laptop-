#!/bin/bash

gfx_mode=$(supergfxctl -g 2>/dev/null || echo "unknown")
echo "{\"text\": \"📈 $gfx_mode\"}"

