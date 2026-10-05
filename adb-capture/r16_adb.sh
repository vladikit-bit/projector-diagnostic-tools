#!/bin/bash
# Robust ADB wrapper for R16:
# - ADB daemon state (connect + root) does NOT persist across separate Bash calls.
# - Therefore we re-connect (and re-root if needed) on EVERY invocation.
A=/c/Android/platform-tools-latest-windows/platform-tools/adb.exe
DEV=192.168.0.183:5555

"$A" start-server >/dev/null 2>&1
"$A" connect "$DEV" >/dev/null 2>&1
sleep 1

who=$("$A" shell id 2>/dev/null | head -1)
case "$who" in
  *root*) ;;                       # already root: connect persists, do nothing
  *)
    "$A" root >/dev/null 2>&1      # transition shell->root restarts daemon (drops TCP)
    sleep 3
    "$A" connect "$DEV" >/dev/null 2>&1
    sleep 1
    ;;
esac

exec "$A" "$@"
