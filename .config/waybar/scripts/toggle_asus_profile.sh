#!/bin/bash

current=$(asusctl profile --profile-get 2>/dev/null | grep -i "Active profile" | awk -F'is ' '{print $2}' | xargs)
case "$current" in
  Quiet)
    asusctl profile -P Balanced
    ;;
  Balanced)
    asusctl profile -P Performance
    ;;
  Performance)
    asusctl profile -P Quiet
    ;;
  *)
    asusctl profile -P Quiet
    ;;
esac
