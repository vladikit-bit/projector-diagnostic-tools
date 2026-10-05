#!/system/bin/sh
# R21 temporal DM capture for one codec. usage: r21_cap.sh <ac3|dts>
KIND=$1
P=/proc/utopia_mdb/audio
OUT=/data/local/tmp/r21_dm_${KIND}.txt
> $OUT
# read DM words 0x4f00..0x4f1f (addr 20224 = 0x4f00, len 128 bytes = 32 words)
dmread() {
  dmesg -c >/dev/null 2>&1
  echo read_dsp_sram_type=1 addr=20224 len=128 > $P
  sleep 0.5
  dmesg | grep -a 'DM\['
}
echo "===== $KIND IDLE (pre-playback) =====" >> $OUT
date >> $OUT
dmread >> $OUT
if [ "$KIND" = "ac3" ]; then
  ARGS="/data/local/tmp/ac3_51.raw ac3raw ac3 2"
else
  ARGS="/data/local/tmp/dts_51.raw dtsraw dts 1"
fi
echo "===== $KIND STARTING playback =====" >> $OUT
date >> $OUT
CLASSPATH=/data/local/tmp/probe7.jar nohup app_process /system/bin --nice-name=probe7 Probe7 $ARGS >/dev/null 2>&1 &
PID=$!
sleep 3
echo "===== $KIND START (t+3s) =====" >> $OUT
date >> $OUT
dmread >> $OUT
sleep 10
echo "===== $KIND STEADY (t+13s) =====" >> $OUT
date >> $OUT
dmread >> $OUT
kill $PID 2>/dev/null
pkill -f probe7 2>/dev/null
sleep 3
echo "===== $KIND STOP (after kill) =====" >> $OUT
date >> $OUT
dmread >> $OUT
echo DONE_$KIND
