#!/bin/bash

bluetoothctl show | grep -q "Powered: yes"
if [ $? -eq 0 ]; then
    device_name=$(bluetoothctl info | grep "Name" | awk '{print $2}')
    if bluetoothctl info | grep -q "Connected: yes"; then
        echo "{\"text\": \" $device_name\", \"tooltip\": \"Bluetooth device connected: $device_name\", \"class\": \"connected\"}"
    else
        echo "{\"text\": \"\", \"tooltip\": \"Bluetooth is on, no device connected\", \"class\": \"on\"}"
    fi
else
    echo "{\"text\": \"󰂲\", \"tooltip\": \"Bluetooth is off\", \"class\": \"off\"}"
fi

