#!/bin/bash
sudo cp etc/systemd/system/sddm-resume.service /etc/systemd/system/
sudo cp etc/systemd/sleep.conf.d/hibernate.conf /etc/systemd/sleep.conf.d/
sudo mkdir -p /usr/lib/systemd/system-sleep
sudo cp usr/lib/systemd/system-sleep/iwlwifi-reset /usr/lib/systemd/system-sleep/iwlwifi-reset
sudo cp usr/lib/systemd/system-sleep/restart-waybar.sh /usr/lib/systemd/system-sleep/restart-waybar.sh
sudo chmod +x /usr/lib/systemd/system-sleep/iwlwifi-reset /usr/lib/systemd/system-sleep/restart-waybar.sh
# Old hibernate-only hook conflicts with iwlwifi-reset (covers all sleep verbs).
if [ -e /usr/lib/systemd/system-sleep/iwlwifi ]; then
  sudo mv /usr/lib/systemd/system-sleep/iwlwifi /usr/lib/systemd/system-sleep/iwlwifi.bak
fi
# Boot entries intentionally excluded - set resume= manually after install
echo "Remember to add resume=UUID=... resume_offset=4814848 to bootloader entries"
sudo systemctl daemon-reload
sudo systemctl enable sddm-resume.service
