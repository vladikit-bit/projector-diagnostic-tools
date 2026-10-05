#!/system/bin/sh
# R15 synchronised capture: DM snapshots + DEC R2 log during playback.
# usage: r15_capture.sh <tag> <ac3|dts> <seconds>
TAG=$1; KIND=$2; SECS=${3:-60}
OUT=/data/local/tmp/r15_$TAG.txt
LOG=/data/local/tmp/r15_$TAG.dec.log
> $OUT
LOGP=/proc/utopia_mdb/audio

echo "dump_r2_log_start=1" > $LOGP
sleep 1

if [ "$KIND" = "ac3" ]; then
  F=/data/local/tmp/ac3_51.raw; ENC=ac3; MODE=ac3raw; N=2
else
  F=/data/local/tmp/dts_51.raw; ENC=dts; MODE=dtsraw; N=1
fi

CLASSPATH=/data/local/tmp/probe7.jar nohup app_process /system/bin --nice-name=probe7 \
    Probe7 $F $MODE $ENC $N >/dev/null 2>&1 &
PID=$!

snap() {
  T=$(cat /proc/uptime | cut -d. -f1)
  echo "### T=$T tag=$TAG kind=$KIND" >> $OUT
  for a in 0x0900 0x0a00 0x0b00 0x0fe0 0x1000 0x1090 0x1bc8 0x1d00; do
    dmesg -c > /dev/null 2>&1
    echo "read_dsp_sram_type=1 addr=$a len=0x100" > $LOGP
    sleep 0.4
    dmesg | grep -a 'DM\[' >> $OUT
  done
}

sleep 1
snap            # ~1s: right after start / init
sleep 4
snap            # ~6s: after dec play
sleep 6
snap            # ~12s
sleep 8
snap            # ~20s: steady
sleep 10
snap            # ~30s: steady
sleep 15
snap            # ~45s
sleep 10
snap            # ~55s

kill $PID 2>/dev/null
pkill -f probe7 2>/dev/null
sleep 2
echo "dump_r2_log_stop=1" > $LOGP
sleep 1
cp /data/AudioDECR2*.log $LOG 2>/dev/null
ls -la /data/AudioDECR2* >> $OUT 2>/dev/null
wc -l $OUT
echo DONE
