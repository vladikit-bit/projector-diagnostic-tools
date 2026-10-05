#!/system/bin/sh
# R17 fresh SND R2 log capture + DM burst-signature sampler during playback.
# usage: r17_capture.sh <ac3|dts> <seconds>
# SND R2 log: dump_r2_log_start=1 9E=0x3f PATH=1 8A=0x1 ; stop: dump_r2_log_stop=1
# DM sampler reads DEC DM 0x0900-0x0C00 (read_dsp_sram_type=1) and tracks the
#   IEC61937 burst signature (Pa=F872 / Pb=4E1F) as a verdict of "burst present".
KIND=$1; SECS=${2:-14}
P=/proc/utopia_mdb/audio
DMOUT=/data/dm_${KIND}_verdict.txt
FULL=/data/dm_${KIND}_full.txt

# stop any running dump, start a fresh SND R2 log
echo stop_dump_r2_log > $P; sleep 1
echo dump_r2_log_stop=1 > $P; sleep 1
rm -f /data/AudioSNDR2_*
echo 'dump_r2_log_start=1 9E=0x3f PATH=1 8A=0x1' > $P
sleep 2
F=$(ls /data/AudioSNDR2_* 2>/dev/null | head -1)
echo "LOGFILE=$F"

# DM sampler (runs concurrently with playback; read-only)
( dmesg -c >/dev/null 2>&1
  for i in $(seq 1 $((SECS+3))); do
    echo "DM @ $(cat /proc/uptime|cut -d. -f1)s $(date +%H:%M:%S)"
    echo 'read_dsp_sram_type=1 addr=0x0900 len=0x400' > $P
    sleep 1
    OUT=$(dmesg -c 2>/dev/null | grep -E 'DM\[0x')
    B=$(printf '%s\n' "$OUT" | grep -iE 'f872|4e1f' | wc -l)
    echo "  burst_sig(f872/4e1f)=$B"
    printf '%s\n' "$OUT" | grep -iE 'f872|4e1f' | head -8
    if [ "$i" -eq 3 ]; then
      echo 'read_dsp_sram_type=1 addr=0x0900 len=0x400' > $P
      sleep 1
      dmesg -c 2>/dev/null | grep -E 'DM\[0x' > $FULL
      echo "  FULL_DUMP -> $FULL ($(wc -l < $FULL) lines)"
    fi
  done
) > $DMOUT 2>&1 &

echo "T0=$(cat /proc/uptime|cut -d. -f1)"; date

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
echo "T1=$(cat /proc/uptime|cut -d. -f1)"
echo dump_r2_log_stop=1 > $P
sleep 1
ls -la /data/AudioSNDR2_*
echo "DMOUT=$DMOUT FULL=$FULL"
echo DONE
