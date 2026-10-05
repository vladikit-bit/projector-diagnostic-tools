#!/system/bin/sh
# r30_cap2.sh - R30 definitive capture via SND R2 firmware-access log + decode-activity check.
# Read-only: /proc/utopia_mdb/audio dump_r2_log_start records actual 0xB000_xxxx MMIO
# reads/writes the SND firmware performs. Plus DEC/DM sample to confirm decode is live.
# usage: r30_cap2.sh <ac3|dts>
KIND=$1
[ -z "$KIND" ] && KIND=dts
P=/proc/utopia_mdb/audio
OUT=/data/local/tmp/r30b_${KIND}
mkdir -p $OUT
LOG=$OUT/cap.log
R2LOG=$OUT/snd_r2.txt
DECDM=$OUT/decdm.txt

echo "R30B START $KIND" > $LOG
date >> $LOG

echo stop_dump_r2_log > $P; sleep 1
echo dump_r2_log_stop=1 > $P; sleep 1
rm -f /data/AudioSNDR2_* 2>/dev/null
echo 'dump_r2_log_start=1 9E=0x3f PATH=1 8A=0x1' > $P
sleep 1
echo "R2LOG_STARTED" >> $LOG

if [ "$KIND" = "ac3" ]; then ARGS="/data/local/tmp/ac3_51.raw ac3raw ac3 2"
else ARGS="/data/local/tmp/dts_51.raw dtsraw dts 1"; fi
CLASSPATH=/data/local/tmp/probe7.jar nohup app_process /system/bin --nice-name=probe7 Probe7 $ARGS >/dev/null 2>&1 &
PID=$!
echo "PROBE_PID=$PID" >> $LOG

sample() {
  lab=$1; addr=$2; len=$3
  dmesg -c >/dev/null 2>&1
  echo read_dsp_sram_type=1 addr=$addr len=$len > $P
  sleep 0.4
  dmesg | grep -a 'DM\['
}
{
  echo "=== DEC t0 (immediately) ==="; sample DEC 0x0fe0 0x40
  sleep 1
  echo "=== DM block t1 ==="; sample DM 0x4ee0 0x50
  sleep 3
  echo "=== DEC t2 ==="; sample DEC 0x0fe0 0x40
  sleep 3
  echo "=== DM block t3 ==="; sample DM 0x4ee0 0x50
} >> $DECDM

kill $PID 2>/dev/null; pkill -f probe7 2>/dev/null
sleep 1
echo dump_r2_log_stop=1 > $P
sleep 1
F=$(ls /data/AudioSNDR2_* 2>/dev/null | head -1)
echo "R2LOG_FILE=$F" >> $LOG
if [ -n "$F" ]; then cp $F $R2LOG; fi
echo "R30B DONE $KIND" >> $LOG
date >> $LOG
