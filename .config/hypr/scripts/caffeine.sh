#!/bin/sh
# Inhibit idle timeouts only — leave hypridle running so before_sleep_cmd
# still locks on lid/suspend/hibernate.

INHIBIT_PIDFILE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/caffeine-idle.pid"

if [ -f "$INHIBIT_PIDFILE" ] && kill -0 "$(cat "$INHIBIT_PIDFILE")" 2>/dev/null; then
	kill "$(cat "$INHIBIT_PIDFILE")" 2>/dev/null
	rm -f "$INHIBIT_PIDFILE"
	notify-send -i /usr/share/icons/Papirus-Dark/symbolic/status/my-caffeine-off-symbolic.svg "Caffeine Disabled"
	exit 0
fi

# Drop stale pidfile if the inhibitor already exited
rm -f "$INHIBIT_PIDFILE"

systemd-inhibit --what=idle --who=caffeine --why='Caffeine enabled' \
	sleep infinity &
echo $! > "$INHIBIT_PIDFILE"
notify-send -i /usr/share/icons/Papirus-Dark/symbolic/status/my-caffeine-on-symbolic.svg "Caffeine Enabled"
