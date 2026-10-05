#!/system/bin/sh
# R16 fresh DEC R2 log capture for one codec.
# usage: r16_capture.sh <ac3|dts> <seconds>
KIND=$1; SECS=${2:-12}
P=/proc/utopia_mdb/audio

# stop any running dump, start a fresh DEC R2 log
echo stop_dump_r2_log > $P; sleep 1
echo dump_r2_log_stop=0 > $P; sleep 1
rm -f /data/AudioDECR2_*
echo 'dump_r2_log_start=0 9E=0x16 PATH=1 8A=0x1' > $P
sleep 2
F=$(ls /data/AudioDECR2_* 2>/dev/null | head -1)
echo "LOGFILE=$F"
echo "T0=$(cat /proc/uptime | cut -d. -f1)"
date

if [ "$KIND" = "ac3" ]; then
  ARGS="/data/local/tmp/ac3_51.raw ac3raw ac3 2"
else
  ARGS="/data/local/tmp/dts_51.raw dtsraw dts 1"
fi
echo "CMD=app_process Probe7 $ARGS"
CLASSPATH=/data/local/tmp/probe7.jar nohup app_process /system/bin --nice-name=probe7 \
    Probe7 $ARGS >/dev/null 2>&1 &
PID=$!
sleep $SECS
kill $PID 2>/dev/null
pkill -f probe7 2>/dev/null
sleep 2
echo "T1=$(cat /proc/uptime | cut -d. -f1)"
echo dump_r2_log_stop=0 > $P
sleep 1
ls -la /data/AudioDECR2_*
echo DONE
