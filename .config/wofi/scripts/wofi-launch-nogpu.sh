#!/usr/bin/env bash
# ~/.config/wofi/scripts/wofi-launch-nogpu.sh
# Two-step wofi launcher: pick GPU mode, then pick app.
#
# Modes:
#   iGPU only   — DRI_PRIME=0 (forces AMD iGPU over NVIDIA on G14)
#   Disable GPU — appends --disable-gpu (Chromium/Electron apps only)

# ── Step 1: Pick mode ────────────────────────────────────────────────────────

MODE=$(printf "iGPU only\nDisable GPU" \
    | wofi --dmenu \
           --prompt "GPU Mode:" \
           --lines 2 \
           --width 300 \
           --hide-scroll)

[[ -z "$MODE" ]] && exit 0

# ── Step 2: Build app list from .desktop files ───────────────────────────────

TMPFILE=$(mktemp /tmp/wofi-nogpu-XXXX)
trap 'rm -f "$TMPFILE"' EXIT

while IFS= read -r desktop; do
    # Skip files we can't read
    [[ -r "$desktop" ]] || continue

    name=$(grep    -m1 "^Name="      "$desktop" | cut -d= -f2-)
    exec_line=$(grep -m1 "^Exec="   "$desktop" | cut -d= -f2-)
    no_display=$(grep -m1 "^NoDisplay=" "$desktop" | cut -d= -f2-)

    # Skip hidden / incomplete entries
    [[ "$no_display" == "true" ]] && continue
    [[ -z "$name" || -z "$exec_line" ]] && continue

    # Strip .desktop field codes (%u %f %F %U %i %c %k etc.)
    exec_clean=$(echo "$exec_line" | sed 's/ \?%[a-zA-Z]//g')

    printf '%s\t%s\n' "$name" "$exec_clean" >> "$TMPFILE"
done < <(find /usr/share/applications ~/.local/share/applications \
             -name "*.desktop" 2>/dev/null \
         | sort -u)

# Deduplicate entries with the same display name (keep first occurrence)
sort -u -t$'\t' -k1,1 "$TMPFILE" -o "$TMPFILE"

# ── Step 3: Show app picker ───────────────────────────────────────────────────

selected=$(cut -f1 "$TMPFILE" \
    | sort \
    | wofi --dmenu \
           --prompt "Launch ($MODE):" \
           --insensitive)

[[ -z "$selected" ]] && exit 0

# Look up the Exec line for the selected app name
exec_cmd=$(awk -F'\t' -v name="$selected" '$1 == name { print $2; exit }' "$TMPFILE")

[[ -z "$exec_cmd" ]] && exit 1

# ── Step 4: Launch ────────────────────────────────────────────────────────────

case "$MODE" in
    "iGPU only")
        # DRI_PRIME=0 forces AMD iGPU; avoids NVIDIA PRIME offload on G14
        env DRI_PRIME=0 $exec_cmd &
        ;;
    "Disable GPU")
        # --disable-gpu works for Chromium, Electron, and most GTK4 apps.
        # Non-Electron apps will typically ignore the unknown flag.
        $exec_cmd --disable-gpu &
        ;;
esac
