#!/bin/bash
# R4 runtime differential: post-parser AC3 vs DTS playback-only windows.
# No dumpsys inside the window (R3 proved dumpsys creates unrelated traffic).
# Structure: for each phase, clear, start playback, settle, capture playback-only
#   logcat + dmesg. Then at the very end, one read-only dumpsys for codec-state reference.
set -u
ADB="C:/Android/platform-tools-latest-windows/platform-tools/adb.exe"
OUT="C:/firmware_temp/spdif_audio_investigation/runtime_phase4"
STAMP=$(date +%Y%m%d_%H%M%S)
mkdir -p "$OUT"
KODI="net.kodinerds.maven.kodi22/.Splash"
SETTLE=14
AC3="/sdcard/testmedia/test_ac3_51.mp4"
DTS="/sdcard/testmedia/test_dts_51.mp4"

"$ADB" connect 192.168.0.183:5555 >/dev/null 2>&1
"$ADB" root >/dev/null 2>&1
sleep 2

run_phase () {
  local PHASE="$1"; shift; local MEDIA="$1"; shift
  local P="${OUT}/R4_${STAMP}_${PHASE}"
  echo "==== R4 phase: $PHASE ===="
  "$ADB" shell "am force-stop net.kodinerds.maven.kodi22"; sleep 4
  "$ADB" shell "logcat -b all -c"; "$ADB" shell "dmesg -c" > "${P}_dmesg_pre.txt"
  if [ "$MEDIA" != "none" ]; then
    "$ADB" shell "am start -n $KODI --es videourl file://$MEDIA" >/dev/null 2>&1
  fi
  sleep $SETTLE
  # playback-only window (NO dumpsys yet)
  "$ADB" shell "logcat -b all -d -v time" > "${P}_playback.logcat"
  "$ADB" shell "dmesg" | grep -v "CEC system busy" > "${P}_playback.dmesg"
  echo "  wrote ${P}_playback.{logcat,dmesg}"
}

run_phase idle "none"
run_phase ac3  "$AC3"
run_phase dts  "$DTS"

# read-only dump, separate, for codec-state reference only
"$ADB" shell "am force-stop net.kodinerds.maven.kodi22"; sleep 3
"$ADB" shell "logcat -b all -c"
"$ADB" shell "dumpsys media.audio_flinger" > "${OUT}/R4_${STAMP}_dump_af.txt"
"$ADB" shell "logcat -b all -d -v time" > "${OUT}/R4_${STAMP}_dump.logcat"
echo "==== R4 playback-only capture complete: $OUT/R4_${STAMP}_* ===="
