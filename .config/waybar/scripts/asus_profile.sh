#!/bin/bash


asusctl_mode=$(asusctl profile --profile-get 2>/dev/null | grep -i "Active profile" | awk -F'is ' '{print $2}' | xargs)

echo "{\"text\": \"🎮 $asusctl_mode\"}"
