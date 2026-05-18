#!/bin/sh
# NVIDIA suspend-then-hibernate fix + waybar resume hook

mkdir -p /etc/systemd/system/nvidia-suspend.service.d/
printf '[Unit]\nBefore=systemd-suspend-then-hibernate.service\n' \
  > /etc/systemd/system/nvidia-suspend.service.d/suspend-then-hibernate.conf

ln -sf /usr/lib/systemd/system/nvidia-suspend.service \
  /etc/systemd/system/systemd-suspend-then-hibernate.service.wants/nvidia-suspend.service

printf '#!/bin/sh\nsudo -u z DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus WAYLAND_DISPLAY=wayland-1 systemctl --user restart waybar\n' \
  > /usr/local/bin/waybar-resume.sh
chmod +x /usr/local/bin/waybar-resume.sh

mkdir -p /etc/systemd/system/nvidia-resume.service.d/
printf '[Service]\nExecStartPost=/usr/local/bin/waybar-resume.sh\n' \
  > /etc/systemd/system/nvidia-resume.service.d/waybar-restart.conf

systemctl daemon-reload
