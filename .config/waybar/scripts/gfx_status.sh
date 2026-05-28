#!/bin/bash

power_file=$(ls /proc/driver/nvidia/gpus/*/power 2>/dev/null | head -1)

if [ -z "$power_file" ]; then
  printf '{"text":"❔ GPU","class":"unknown","tooltip":"NVIDIA driver not loaded"}
'
  exit 0
fi

video_mem=$(grep "Video Memory:" "$power_file" | awk '{print $NF}')

if [ "$video_mem" = "Off" ]; then
  printf '{"text":"💤 dGPU","class":"suspended","tooltip":"NVIDIA GPU suspended (runtime D3)"}
'
else
  printf '{"text":"🖵 dGPU","class":"active","tooltip":"NVIDIA GPU active"}
'
fi
