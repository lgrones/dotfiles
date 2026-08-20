#!/usr/bin/env bash
# Sync OpenRGB devices to the current caelestia scheme.
# Called from the caelestia postHook (cli.json), which exports SCHEME_COLOURS
# as a JSON object of name -> bare hex (no leading #).
# Standalone runs fall back to reading the scheme state file directly.

set -u

colour=$(
  if [ -n "${SCHEME_COLOURS:-}" ]; then
    printf '%s' "$SCHEME_COLOURS" | python3 -c 'import json,sys; print(json.load(sys.stdin)["primary"])'
  else
    python3 -c 'import json,os,pathlib,sys
state = os.environ.get("XDG_STATE_HOME") or str(pathlib.Path.home() / ".local/state")
print(json.load(open(state + "/caelestia/scheme.json"))["colours"]["primary"])'
  fi
) 2>/dev/null || exit 0

[ -n "$colour" ] || exit 0
command -v openrgb >/dev/null || exit 0

openrgb --mode static --color "$colour" >/dev/null 2>&1
