#!/bin/bash
sudo cp etc/systemd/system/sddm-resume.service /etc/systemd/system/
sudo cp etc/systemd/system/waybar-resume.service /etc/systemd/system/
sudo cp etc/systemd/sleep.conf.d/hibernate.conf /etc/systemd/sleep.conf.d/
# Boot entries intentionally excluded - set resume= manually after install
echo "Remember to add resume=UUID=... resume_offset=4814848 to bootloader entries"
sudo systemctl daemon-reload
sudo systemctl enable sddm-resume.service waybar-resume.service
