#!/system/bin/sh
# R38 read-only runtime observation of SND R2 SHM tail fields.
# No patching, no config change, no firmware change.
P=/proc/utopia_mdb/audio
OUT=/data/local/tmp/r38_out
mkdir -p $OUT
A=$OUT/all.txt
rm -f $A

sample() {
  label=$1
  dmesg -c >/dev/null 2>&1
  echo "read_dsp_sram_type=1 addr=0xa100 len=0x60" > $P
  sleep 0.8
  echo "=== $label VALID ===" >> $A
  dmesg | grep 'DM\[' >> $A
  dmesg -c >/dev/null 2>&1
  echo "read_dsp_sram_type=1 addr=0xa850 len=0x60" > $P
  sleep 0.8
  echo "=== $label TAIL ===" >> $A
  dmesg | grep 'DM\[' >> $A
}

echo "R38 START $(date)" >> $A
sample IDLE_1
sleep 2
sample IDLE_2

# ---------- AC3 ----------
echo "AC3 LAUNCH $(date)" >> $A
am start -n net.kodinerds.maven.kodi22/.Splash -d "file:///storage/emulated/0/Movies/test_ac3_51.mp4" >> $A 2>&1
sleep 7
sample AC3_T1
sleep 5
sample AC3_T2
sleep 5
sample AC3_T3
am force-stop net.kodinerds.maven.kodi22
sleep 4
sample AC3_STOP

# ---------- DTS ----------
echo "DTS LAUNCH $(date)" >> $A
am start -n net.kodinerds.maven.kodi22/.Splash -d "file:///storage/emulated/0/Movies/test_dts_51.mp4" >> $A 2>&1
sleep 7
sample DTS_T1
sleep 5
sample DTS_T2
sleep 5
sample DTS_T3
am force-stop net.kodinerds.maven.kodi22
sleep 4
sample DTS_STOP

echo "R38 DONE $(date)" >> $A
