#!/system/bin/sh
# r22_cap.sh - R22 high-frequency temporal DM sampler (read-only, no patches)
# usage: r22_cap.sh <dts|ac3> <probe7|realkodi>
#   probe7   : launches Probe7 direct decoder, auto-triggers on DEC change
#   realkodi : waits for user to start Kodi passthrough playback (auto-triggers)
# Captures DM regions R1(0x4ee0-0x4f30) R2(0x0900-0x0910) DEC(0x0fe0-0x10d0)
# plus logcat (userspace) and kernel audio dmesg, around playback start/stop.
KIND=$1
MODE=$2
P=/proc/utopia_mdb/audio
BASE=/data/local/tmp/r22
OUT=$BASE/${KIND}_${MODE}
mkdir -p $OUT
DMFILE=$OUT/dm.txt
TL=$OUT/timeline.txt
KERNLOG=$OUT/kernel.log
LOGCAT=$OUT/logcat.txt
> $DMFILE
> $TL
> $KERNLOG

reg1_addr=20208; reg1_len=81    # 0x4ee0-0x4f30
reg2_addr=2304;  reg2_len=17    # 0x0900-0x0910
dec_addr=4064;  dec_len=241     # 0x0fe0-0x10d0

START=$(date +%s)
elapsed() { now=$(date +%s); echo $((now - START)); }

# sample one region: capture real kernel lines first, clear dmesg, read, dump DM lines
sampledm() {
  lab=$1; addr=$2; len=$3
  dmesg | grep -av 'DM\[' >> $KERNLOG 2>/dev/null
  dmesg -c >/dev/null 2>&1
  echo read_dsp_sram_type=1 addr=$addr len=$len > $P
  sleep 0.4
  dmesg | grep -a 'DM\['
}

fullsample() {
  ph=$1
  e=$(elapsed)
  d=$(date +%H:%M:%S)
  {
    echo "=== T${e}s ${ph} ${d} ==="
    echo "-- R1 0x4ee0-0x4f30 --"
    sampledm R1 $reg1_addr $reg1_len
    echo "-- R2 0x0900-0x0910 --"
    sampledm R2 $reg2_addr $reg2_len
    echo "-- DEC 0x0fe0-0x10d0 --"
    sampledm DEC $dec_addr $dec_len
  } >> $DMFILE
}

# normalized DEC signature (strip leading [ts] prefix)
dec_sig() {
  sampledm DEC $dec_addr $dec_len | sed 's/^\[[^]]*\] //'
}

# true if 0x0900 is nonzero
r2_active() {
  r2=$(sampledm R2 $reg2_addr $reg2_len)
  echo "$r2" | grep -q 'DM\[0x0900\] = 0x000000'
  # returns 0 (true) if zero -> caller treats as not-active
  return $?
}

echo "R22_CAP START kind=$KIND mode=$MODE out=$OUT"
date

# clear logs, start logcat capture (userspace boundary)
logcat -b all -c 2>/dev/null
logcat -b all -v time > $LOGCAT 2>/dev/null &
LOGCAT_PID=$!
# continuous kernel message capture (preserves open-time MI_AUDIO_Start / codec-open
# events that sampledm()'s per-sample `dmesg -c` would otherwise discard)
dmesg -c >/dev/null 2>&1
dmesg -w > $OUT/kernfull.txt 2>/dev/null &
KERN_PID=$!

# launch decoder for probe7 mode
if [ "$MODE" = "probe7" ]; then
  if [ "$KIND" = "ac3" ]; then
    ARGS="/data/local/tmp/ac3_51.raw ac3raw ac3 2"
  else
    ARGS="/data/local/tmp/dts_51.raw dtsraw dts 1"
  fi
  echo "launching Probe7 $ARGS"
  CLASSPATH=/data/local/tmp/probe7.jar nohup app_process /system/bin --nice-name=probe7 Probe7 $ARGS >/dev/null 2>&1 &
  PROBE_PID=$!
fi

# baseline idle sample
fullsample BASELINE
BASEDEC=$(dec_sig)
echo "baseline DEC captured, len=${#BASEDEC}"
echo "IDLE_POLL: waiting for ${KIND} playback start -- START A FRESH ${KIND} PASSTHROUGH TRACK IN KODI NOW"

# idle poll until trigger
MAXIDLE=240
TRIG=0
i=0
while [ $i -lt $MAXIDLE ]; do
  cur=$(dec_sig)
  if [ "$cur" != "$BASEDEC" ]; then
    echo "TRIGGER: DEC changed at T$(elapsed)s"; TRIG=1; break; fi
  if ! r2_active; then
    echo "TRIGGER: 0x0900 active at T$(elapsed)s"; TRIG=1; break; fi
  sleep 1.5
  i=$((i+1))
done

if [ $TRIG -eq 0 ]; then
  echo "NO_PLAYBACK within ${MAXIDLE}s"
  kill $LOGCAT_PID 2>/dev/null
  echo "R22_CAP DONE_NO_PLAYBACK"
  exit 0
fi

# transition: high-frequency capture ~22s
fullsample TRANSITION
h=0
while [ $h -lt 22 ]; do
  fullsample HF
  sleep 0.2
  h=$((h+1))
done

# medium-frequency until stop detected (~28s)
m=0
STOP=0
while [ $m -lt 28 ]; do
  fullsample MED
  cur=$(dec_sig)
  if [ "$cur" = "$BASEDEC" ] && r2_active; then
    echo "STOP detected at T$(elapsed)s"; STOP=1; break; fi
  sleep 1.0
  m=$((m+1))
done

# post-stop samples
fullsample STOP
p=0
while [ $p -lt 5 ]; do
  fullsample POSTSTOP
  sleep 1.0
  p=$((p+1))
done

kill $LOGCAT_PID 2>/dev/null
kill $KERN_PID 2>/dev/null
# final kernel log flush
dmesg | grep -av 'DM\[' >> $KERNLOG 2>/dev/null
echo "R22_CAP DONE kind=$KIND mode=$MODE"
