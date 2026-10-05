#!/bin/bash
# Focused: start media, wait longer, capture playback-only window.
ADB="C:/Android/platform-tools-latest-windows/platform-tools/adb.exe"
OUT="C:/firmware_temp/spdif_audio_investigation/runtime_phase4"
STAMP=$(date +%Y%m%d_%H%M%S)
KODI="net.kodinerds.maven.kodi22/.Splash"
SETTLE=22
"$ADB" connect 192.168.0.183:5555 >/dev/null 2>&1; "$ADB" root >/dev/null 2>&1; sleep 2
run () {
  local PH="$1"; local MED="$2"; local P="$OUT/R4b_${STAMP}_${PH}"
  echo "==== $PH ===="
  "$ADB" shell "am force-stop net.kodinerds.maven.kodi22"; sleep 4
  "$ADB" shell "logcat -b all -c"; "$ADB" shell "dmesg -c" > "${P}_dmesg_pre.txt"
  "$ADB" shell "am start -n $KODI --es videourl file://$MED" >/dev/null 2>&1
  sleep "$SETTLE"
  "$ADB" shell "logcat -b all -d -v time" > "${P}_playback.logcat"
  "$ADB" shell "dmesg" | grep -v "CEC system busy" > "${P}_playback.dmesg"
  echo "  lines: $(wc -l < ${P}_playback.logcat)  out_write=$(grep -c out_write ${P}_playback.logcat)  mi_decoder_open=$(grep -c mi_decoder_open ${P}_playback.logcat)  Parser_Write=$(grep -c Parser_Write ${P}_playback.logcat)"
}
run ac3 "/sdcard/testmedia/test_ac3_51.mp4"
run dts "/sdcard/testmedia/test_dts_51.mp4"
echo "done"
