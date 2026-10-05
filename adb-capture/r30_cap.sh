#!/system/bin/sh
# r30_cap.sh - R30 targeted MMIO capture of the 0x25EE1 gate + output-enable registers.
# Read-only: uses /proc/utopia_mdb/audio read_dsp_sram_type=1 (no MMIO writes, no patch).
# Drives decode via probe7 (same DSP output path as real Kodi passthrough, per R22).
# usage: r30_cap.sh <ac3|dts>
KIND=$1
[ -z "$KIND" ] && KIND=dts
P=/proc/utopia_mdb/audio
OUT=/data/local/tmp/r30_${KIND}
mkdir -p $OUT
DM=$OUT/dm.txt
LOG=$OUT/cap.log
> $DM
> $LOG

sample() {
  lab=$1; addr=$2; len=$3
  dmesg -c >/dev/null 2>&1
  echo read_dsp_sram_type=1 addr=$addr len=$len > $P
  sleep 0.4
  dmesg | grep -a 'DM\['
}

# W1: gate in 0x0015, finalizer outs 0x0020/0x003E (+ context)
# W2: AC3 out-en 0x0854, DTS out-en 0x086C/0x0870 (+ context)
# W3: gate in 0x0C06 bit7 (+ context)
full() {
  ph=$1
  d=$(date +%H:%M:%S)
  {
    echo "=== ${ph} ${d} ==="
    echo "-- W1 0x0010-0x0060 --"
    sample W1 0x0010 0x50
    echo "-- W2 0x0840-0x0890 --"
    sample W2 0x0840 0x50
    echo "-- W3 0x0C00-0x0C30 --"
    sample W3 0x0C00 0x30
  } >> $DM
}

echo "R30_CAP START kind=$KIND" >> $LOG
date >> $LOG

# baseline idle (no playback)
full BASELINE

if [ "$KIND" = "ac3" ]; then ARGS="/data/local/tmp/ac3_51.raw ac3raw ac3 2"
else ARGS="/data/local/tmp/dts_51.raw dtsraw dts 1"; fi
CLASSPATH=/data/local/tmp/probe7.jar nohup app_process /system/bin --nice-name=probe7 Probe7 $ARGS >/dev/null 2>&1 &
PID=$!
echo "PROBE_PID=$PID" >> $LOG

sleep 2; full TRANSITION
sleep 2; full STEADY1
sleep 2; full STEADY2
sleep 2; full STEADY3

kill $PID 2>/dev/null; pkill -f probe7 2>/dev/null
sleep 2; full STOP
sleep 2; full POSTSTOP

echo "R30_CAP DONE kind=$KIND" >> $LOG
date >> $LOG
