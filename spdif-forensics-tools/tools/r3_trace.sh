#!/bin/bash
# R3 differential trace.
#
# For each phase (idle / ac3 / dts) it captures TWO separate logcat windows:
#   1) <phase>_playback.logcat  - messages produced by playback alone
#   2) <phase>_dump.logcat      - messages produced ONLY by `dumpsys media.audio_flinger`
#                                 (this is what invokes HAL adev_dump -> mi_getCodecType)
# The split is what lets us decide R3-A (DTS-specific failure on the playback path)
# vs R3-B (mi_getCodecType errors are a generic side effect of the dump path).
#
# No binaries are modified, no EDID/ARC/topology changes, no config changes
# other than starting/stopping Kodi playback.
set -u

ADB="C:/Android/platform-tools-latest-windows/platform-tools/adb.exe"
OUT="/c/firmware_temp/spdif_audio_investigation/runtime_phase3"
KODI="net.kodinerds.maven.kodi22/.Splash"
STAMP=$(date +%Y%m%d_%H%M%S)
SETTLE=14

mkdir -p "$OUT"

run_phase () {
  local PHASE="$1"; shift
  local FILE="$1"; shift
  local P="${OUT}/R3_${STAMP}_${PHASE}"

  echo "############ [${PHASE}] ############"
  $ADB shell "am force-stop net.kodinerds.maven.kodi22" >/dev/null 2>&1
  sleep 4
  $ADB shell "logcat -b all -c" >/dev/null 2>&1
  $ADB shell "dmesg -c" > "${P}_dmesg_pre.txt" 2>&1

  if [ "$FILE" != "none" ]; then
    echo "  -> launching $FILE"
    $ADB shell "am start -a android.intent.action.VIEW -d 'file://${FILE}' -t 'video/mp4' -n ${KODI}" 2>&1 | tail -2
    echo "  -> settling ${SETTLE}s"
    sleep $SETTLE
  else
    echo "  -> idle (no playback), settling 6s"
    sleep 6
  fi

  # ---- window 1: playback only (no dumpsys yet)
  $ADB shell "logcat -b all -d -v time" > "${P}_playback.logcat" 2>&1
  $ADB shell "dmesg" 2>&1 | grep -v 'CEC system busy' > "${P}_playback.dmesg" 2>&1

  # ---- window 2: dump induced only
  $ADB shell "logcat -b all -c" >/dev/null 2>&1
  $ADB shell "dumpsys media.audio_flinger" > "${P}_af.txt" 2>&1
  $ADB shell "logcat -b all -d -v time" > "${P}_dump.logcat" 2>&1

  echo "  written: ${P}_{playback.logcat,dump.logcat,af.txt}"
}

run_phase idle "none"
run_phase ac3  "/sdcard/testmedia/test_ac3_51.mp4"
run_phase dts  "/sdcard/testmedia/test_dts_51.mp4"

echo "############ done: ${STAMP} ############"
ls -la "${OUT}/R3_${STAMP}_"* 2>/dev/null
