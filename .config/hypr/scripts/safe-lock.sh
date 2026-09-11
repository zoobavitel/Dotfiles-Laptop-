#!/bin/sh
# Safe single-instance hyprlock launcher.
# - Serializes launches (flock) so Super+L / hypridle / before_sleep can't race
# - If this session is already LockedHint=yes and a live hyprlock exists → no-op
# - If hyprlock PIDs exist but we're NOT locked (zombie / wrong display) → kill only
#   those on THIS WAYLAND_DISPLAY, then start fresh
# - Never pkill a healthy lock (LockedHint=yes)

set -eu

RUNTIME="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
WD="${WAYLAND_DISPLAY:-}"
SESSION="${XDG_SESSION_ID:-}"

mkdir -p "$RUNTIME"
exec 9>"$RUNTIME/hyprlock-launch.lock"
# Another lock attempt in flight — bail (don't stack)
flock -n 9 || exit 0

locked_hint() {
    [ -n "$SESSION" ] || return 1
    [ "$(loginctl show-session "$SESSION" -p LockedHint --value 2>/dev/null || true)" = "yes" ]
}

hyprlock_on_this_display() {
    pidof -q hyprlock 2>/dev/null || return 1
    [ -n "$WD" ] || return 0
    for pid in $(pidof hyprlock 2>/dev/null); do
        if tr '\0' '\n' <"/proc/$pid/environ" 2>/dev/null | grep -Fxq "WAYLAND_DISPLAY=$WD"; then
            echo "$pid"
            return 0
        fi
    done
    return 1
}

# Healthy lock already up
if locked_hint; then
    if hyprlock_on_this_display >/dev/null; then
        exit 0
    fi
    # LockedHint=yes but no locker on this display → Oopsie / restore path
fi

# Wedged: process alive on this display but session not locked
for pid in $(hyprlock_on_this_display || true); do
    if ! locked_hint; then
        kill -TERM "$pid" 2>/dev/null || true
    fi
done

# Brief wait for compositor to drop dead lock surfaces
i=0
while hyprlock_on_this_display >/dev/null 2>&1 && [ "$i" -lt 30 ]; do
    if locked_hint; then
        exit 0
    fi
    sleep 0.1
    i=$((i + 1))
done

# Force-kill leftovers on this display only
for pid in $(hyprlock_on_this_display || true); do
    if ! locked_hint; then
        kill -KILL "$pid" 2>/dev/null || true
    fi
done
sleep 0.15

# Re-check after cleanup — another path may have locked us
if locked_hint && hyprlock_on_this_display >/dev/null; then
    exit 0
fi

exec hyprlock "$@"
