#!/usr/bin/env bash
# Sync OpenRGB devices to the current caelestia scheme.
#
# Called from the caelestia postHook (cli.json), which exports SCHEME_COLOURS
# as a JSON object of name -> bare hex (no leading #). Also called on
# hyprland.start from hypr/hyprland/execs.lua, replacing the old
# `openrgb -p catppuccin.orp` profile load.
#
# --noautoconnect is load-bearing: without it OpenRGB tries to reach a server
# on localhost:6742 first, and when that fails ("Connection attempt failed")
# it never falls through to applying locally -- the LEDs keep the board's
# firmware default. Static mode is used because this controller persists it;
# Direct mode only holds while a client stays connected.
#
# WHITE BALANCE: these LEDs are blue-dominant, so a low-saturation warm colour
# like #ffddcd (cream) comes out light blue. The channels are NOT swapped --
# pure red renders red -- the blue emitter is just far brighter per unit PWM.
# The gains below attenuate green and blue so warm tones read warm. Raise
# GAIN_B if colours look too orange, lower it if they still skew blue.
# Override per-run for quick tuning, e.g.:
#     GAIN_B=0.5 ~/.config/caelestia/openrgb-sync.sh

set -u

GAIN_R=${GAIN_R:-1.00}
GAIN_G=${GAIN_G:-0.75}
GAIN_B=${GAIN_B:-0.35}

# Optional: lift washed-out colours toward a hue the LEDs can actually show.
# 0 disables. 0.6 means "push saturation to at least 60%".
MIN_SAT=${MIN_SAT:-0.0}

raw=$(
  if [ -n "${SCHEME_COLOURS:-}" ]; then
    printf '%s' "$SCHEME_COLOURS" | python3 -c 'import json,sys; print(json.load(sys.stdin)["primary"])'
  else
    python3 -c 'import json,os,pathlib,sys
state = os.environ.get("XDG_STATE_HOME") or str(pathlib.Path.home() / ".local/state")
print(json.load(open(state + "/caelestia/scheme.json"))["colours"]["primary"])'
  fi
) 2>/dev/null || exit 0

[ -n "$raw" ] || exit 0
command -v openrgb >/dev/null || exit 0

colour=$(python3 - "$raw" "$GAIN_R" "$GAIN_G" "$GAIN_B" "$MIN_SAT" <<'PY'
import colorsys, sys

raw = sys.argv[1].lstrip("#")
gr, gg, gb, min_sat = map(float, sys.argv[2:6])
r, g, b = (int(raw[i:i + 2], 16) / 255 for i in (0, 2, 4))

if min_sat > 0:
    h, s, v = colorsys.rgb_to_hsv(r, g, b)
    r, g, b = colorsys.hsv_to_rgb(h, max(s, min_sat), v)

print("".join(f"{min(255, max(0, round(c * gain * 255))):02x}"
               for c, gain in ((r, gr), (g, gg), (b, gb))))
PY
) || exit 0

# ZONE SIZES: since OpenRGB 1.0 the CLI does not apply the zone sizes stored in
# Configuration.json, so the board's three ARGB headers come up with 0 LEDs and
# the static write never reaches the fans (they stay on firmware rainbow).
# Pass the sizes explicitly on every run. Selecting the board by name means
# other controllers are no longer covered implicitly -- add a -d block per
# new device (e.g. the Lian Li AIO once its USB header is connected).
openrgb --noautoconnect \
    --device "B850 AORUS STEALTH ICE" \
    --zone 0 --size 20 --zone 1 --size 20 --zone 2 --size 20 \
    --mode static --color "$colour" >/dev/null 2>&1
