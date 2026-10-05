#!/usr/bin/env bash
# R15 adb helper: connect to the C50A and ensure root.
# Usage:  source tools/r15_adb.sh        (then use $A shell ...)
#     or: tools/r15_adb.sh shell <cmd>
A=/c/Android/platform-tools-latest-windows/platform-tools/adb.exe
DEV=192.168.0.183:5555

r15_up() {
  "$A" start-server >/dev/null 2>&1
  "$A" connect $DEV >/dev/null 2>&1
  sleep 1
  if ! "$A" devices 2>/dev/null | grep -q "$DEV.*device"; then
    echo "!! device not connected" >&2; return 1
  fi
  if ! "$A" shell id 2>/dev/null | grep -q "uid=0(root)"; then
    "$A" root >/dev/null 2>&1
    sleep 3
    "$A" connect $DEV >/dev/null 2>&1
    sleep 1
  fi
  "$A" shell id 2>/dev/null | head -1
}

# convenient DM read: r15_dm <addr> <len>  -> prints dmesg DM[] lines
r15_dm() {
  local addr=$1 len=${2:-0x20}
  r15_up >/dev/null || return 1
  "$A" shell "dmesg -c >/dev/null 2>&1; echo 'read_dsp_sram_type=1 addr=$addr len=$len' > /proc/utopia_mdb/audio; sleep 0.5; dmesg | grep -a 'DM\['"
}

r15_pm() {
  local addr=$1 len=${2:-0x20}
  r15_up >/dev/null || return 1
  "$A" shell "dmesg -c >/dev/null 2>&1; echo 'read_dsp_sram_type=0 addr=$addr len=$len' > /proc/utopia_mdb/audio; sleep 0.5; dmesg | grep -a -E 'PM\[|DM\['"
}

if [ $# -gt 0 ]; then
  r15_up >/dev/null
  "$A" "$@"
fi
