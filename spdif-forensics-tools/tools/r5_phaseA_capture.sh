#!/bin/bash
# R5 Phase A: AC3-vs-DTS runtime observation using the vendor MI_AUDIO debug CLI.
# Strategy: start playback -> wait for decoder handle -> issue READ-ONLY debug
# commands -> capture dmesg. No dumpsys. No binary/EDID/property changes.
#
# Usage: r5_phaseA_capture.sh <ac3|dts> [outdir]

ADB="C:/Android/platform-tools-latest-windows/platform-tools/adb.exe"
KODI="net.kodinerds.maven.kodi22/.Splash"
TAG="${1:-ac3}"
OUT="${2:-C:/firmware_temp/spdif_audio_investigation/runtime_phase5}"
SETTLE=${SETTLE:-14}

case "$TAG" in
  ac3) MEDIA="/sdcard/Movies/test_ac3_51.mp4" ;;
  dts) MEDIA="/sdcard/Movies/test_dts_51.mp4" ;;
  *)   echo "unknown tag $TAG"; exit 1 ;;
esac

STAMP=$(date +%Y%m%d_%H%M%S)
BASE="$OUT/R5a_${STAMP}_${TAG}"
mkdir -p "$OUT"

echo "=== R5 Phase A capture: $TAG ($MEDIA) ==="
echo "    output: $BASE"

# --- 0. clean slate -------------------------------------------------------
"$ADB" shell am force-stop net.kodinerds.maven.kodi22
sleep 2
"$ADB" shell "dmesg -c > /dev/null 2>&1"
"$ADB" logcat -c

# --- 1. start playback ----------------------------------------------------
echo "    starting playback..."
"$ADB" shell am start -a android.intent.action.VIEW \
    -d "file://$MEDIA" -t "video/mp4" -n "$KODI" > /dev/null 2>&1
sleep "$SETTLE"

# --- 2. confirm playback is live -----------------------------------------
# NOTE: no dumpsys here - R5 forbids it inside the playback window.
echo "    playback state:"
PLAY=$("$ADB" shell "logcat -d 2>/dev/null" | grep -c "enter PLAY")
echo "      'enter PLAY' occurrences: $PLAY"

# --- 3. issue read-only debug commands ------------------------------------
for CMD in PrintAudioConfig PrintGetCaps; do
  echo "    --- debug cmd: $CMD ---"
  "$ADB" shell "dmesg -c > /dev/null 2>&1"
  "$ADB" shell "echo -n '$CMD' > /sys/kernel/mik/MI_AUDIO"
  sleep 2
  {
    echo "########## R5 Phase A : $TAG : cmd=$CMD ##########"
    "$ADB" shell "dmesg | grep -v 'CEC system busy'"
    echo
  } >> "$BASE.dmesg"
done

# --- 4. final playback window (clean) -------------------------------------
"$ADB" shell "dmesg -c > /dev/null 2>&1"
sleep 6
{
  echo "########## R5 Phase A : $TAG : clean playback window ##########"
  "$ADB" shell "dmesg | grep -v 'CEC system busy'"
} >> "$BASE.dmesg"

# --- 5. capture logcat ----------------------------------------------------
"$ADB" shell "logcat -d" > "$BASE.logcat" 2>&1

# --- 6. stop --------------------------------------------------------------
"$ADB" shell am force-stop net.kodinerds.maven.kodi22
sleep 1

echo "    done -> $BASE.dmesg / $BASE.logcat"
