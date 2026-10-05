#!/system/bin/sh
# r30_realkodi_cap.sh - R30 capture during REAL Kodi passthrough (HAL-driven output config).
# Launches Kodi with a DTS/AC3 test file, captures the 0x25EE1 gate inputs + output-enable
# registers + DEC/DM activity (to confirm passthrough engaged). Read-only MMIO reads only.
# usage: r30_realkodi_cap.sh <ac3|dts>
KIND=$1
[ -z "$KIND" ] && KIND=dts
P=/proc/utopia_mdb/audio
KPKG=net.kodinerds.maven.kodi22
OUT=/data/local/tmp/r30r_${KIND}
mkdir -p $OUT
DM=$OUT/dm.txt
LOG=$OUT/cap.log
> $DM; > $LOG

if [ "$KIND" = "ac3" ]; then F="/storage/emulated/0/Movies/test_ac3_51.mp4"
else F="/storage/emulated/0/Movies/test_dts_51.mp4"; fi

sample() {
  lab=$1; addr=$2; len=$3
  dmesg -c >/dev/null 2>&1
  echo read_dsp_sram_type=1 addr=$addr len=$len > $P
  sleep 0.4
  dmesg | grep -a 'DM\['
}
full() {
  ph=$1
  d=$(date +%H:%M:%S)
  { echo "=== ${ph} ${d} ==="
    echo "-- W1 0x0010-0x0060 (gate0x0015,fin0x0020/0x003E) --"; sample W1 0x0010 0x50
    echo "-- W2 0x0840-0x0890 (out0x0854/0x086C/0x0870) --"; sample W2 0x0840 0x50
    echo "-- W3 0x0C00-0x0C30 (gate0x0C06) --"; sample W3 0x0C00 0x30
    echo "-- DEC 0x0fe0-0x1020 (decode active?) --"; sample DEC 0x0fe0 0x40
    echo "-- DMblk 0x4ee0-0x4f10 (IEC/passthrough?) --"; sample DM 0x4ee0 0x30
  } >> $DM
}

echo "R30R START $KIND file=$F" > $LOG
date >> $LOG

full BASELINE

am start -n $KPKG/.Splash -d "file://$F" >/dev/null 2>&1
echo "LAUNCHED $F" >> $LOG

# fixed wait for Kodi to begin passthrough playback
sleep 7
full TRANSITION
sleep 2; full STEADY1
sleep 2; full STEADY2
sleep 2; full STEADY3

# confirm passthrough engaged (DEC active + IEC block nonzero)
dmesg -c >/dev/null 2>&1
echo read_dsp_sram_type=1 addr=0x0900 len=4 > $P; sleep 0.4
echo "IEC0900=$(dmesg | grep -a 'DM\[0x0900\]')" >> $LOG
dmesg -c >/dev/null 2>&1
echo read_dsp_sram_type=1 addr=0x4ef0 len=4 > $P; sleep 0.4
echo "IEC4ef0=$(dmesg | grep -a 'DM\[0x4ef0\]')" >> $LOG

am force-stop $KPKG
sleep 2; full STOP
sleep 2; full POSTSTOP
echo "R30R DONE $KIND" >> $LOG
date >> $LOG
