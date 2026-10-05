#!/bin/bash
# R1-D verbose AOUT trace. Raises mik AOUT debug verbosity TEMPORARILY,
# traces AC3 + DTS, then restores the original value.
# Non-destructive: only a kernel print-level knob, restored at the end.
set -u
ADB="C:/Android/platform-tools-latest-windows/platform-tools/adb.exe"
OUT="/c/firmware_temp/spdif_audio_investigation/runtime_phase1"
KODI="net.kodinerds.maven.kodi22/.Splash"
PARAM="/sys/module/mik/parameters/mi_aout_amp_debuglevel"
ORIG=32
STAMP=$(date +%Y%m%d_%H%M%S)

restore() { echo "=== restoring debuglevel to $ORIG ==="; $ADB shell "echo $ORIG > $PARAM" >/dev/null 2>&1; }
trap restore EXIT

$ADB shell "echo 63 > $PARAM" >/dev/null 2>&1
echo "debuglevel now: $($ADB shell cat $PARAM)"

for TAG in dts ac3; do
  P="${OUT}/R1_verbose_${TAG}_${STAMP}"
  echo "########## [${TAG}] start ##########"
  $ADB shell "am force-stop net.kodinerds.maven.kodi22" >/dev/null 2>&1
  sleep 3
  $ADB shell "dmesg -c" > "${P}_dmesg_pre.txt" 2>&1
  $ADB shell "am start -a android.intent.action.VIEW -d 'file:///sdcard/testmedia/test_${TAG}_51.mp4' -t 'video/mp4' -n ${KODI}" 2>&1 | tail -1
  sleep 16
  $ADB shell "dmesg" 2>&1 | grep -v 'CEC system busy' | sed 's/\x1b\[[0-9;]*m//g' > "${P}_dmesg_verbose.txt"
  echo "  captured $(wc -l < "${P}_dmesg_verbose.txt") non-CEC kernel lines"
done

restore
echo "debuglevel restored to: $($ADB shell cat $PARAM)"
