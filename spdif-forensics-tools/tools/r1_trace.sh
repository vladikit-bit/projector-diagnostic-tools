#!/bin/bash
# R1-D differential trace: AC3 control vs DTS failure.
# Usage: r1_trace.sh <ac3|dts|eac3>
# Read-only w.r.t. system binaries; only starts/stops Kodi playback.
set -u

ADB="C:/Android/platform-tools-latest-windows/platform-tools/adb.exe"
OUT="/c/firmware_temp/spdif_audio_investigation/runtime_phase1"
KODI="net.kodinerds.maven.kodi22/.Splash"
TAG="$1"

case "$TAG" in
  ac3)  FILE="/sdcard/testmedia/test_ac3_51.mp4" ;;
  dts)  FILE="/sdcard/testmedia/test_dts_51.mp4" ;;
  eac3) FILE="/sdcard/testmedia/test_eac3_51.mp4" ;;
  *) echo "unknown tag $TAG"; exit 1 ;;
esac

STAMP=$(date +%Y%m%d_%H%M%S)
P="${OUT}/R1_trace_${TAG}_${STAMP}"

echo "=== [${TAG}] stopping Kodi, clearing logs ==="
$ADB shell "am force-stop net.kodinerds.maven.kodi22" >/dev/null 2>&1
sleep 3
$ADB shell "logcat -b all -c" >/dev/null 2>&1
$ADB shell "dmesg -c" > "${P}_dmesg_pre.txt" 2>&1

echo "=== [${TAG}] launching playback: ${FILE} ==="
$ADB shell "am start -a android.intent.action.VIEW -d 'file://${FILE}' -t 'video/mp4' -n ${KODI}" 2>&1 | tail -3

# wait for sink to settle / playback to become active
echo "=== [${TAG}] settling 14s ==="
sleep 14

echo "=== [${TAG}] capturing DURING-playback state ==="
$ADB shell "dumpsys media.audio_flinger" > "${P}_audioflinger_during.txt" 2>&1
$ADB shell "dumpsys media.audio_policy"  > "${P}_audiopolicy_during.txt"  2>&1
$ADB shell "dumpsys audio"               > "${P}_dumpsysaudio_during.txt" 2>&1
$ADB shell "ps -A | grep -Ei 'kodi|audioserver|audio-hal'" > "${P}_ps_during.txt" 2>&1
$ADB shell "logcat -b all -d -v time"    > "${P}_logcat_during.txt" 2>&1
$ADB shell "dmesg" 2>&1 | grep -v 'CEC system busy' > "${P}_dmesg_during.txt"
$ADB shell "cat /data/media/0/Android/data/net.kodinerds.maven.kodi22/files/.kodi/temp/kodi.log" > "${P}_kodilog.txt" 2>&1

echo "=== [${TAG}] artifacts written: ${P}_* ==="
ls -la "${P}"* 2>/dev/null
