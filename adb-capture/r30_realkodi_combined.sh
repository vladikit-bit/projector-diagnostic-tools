#!/system/bin/sh
# R30 combined capture: prove DTS decode (DEC 0x0fe0) AND gate input (0x0C06/0x0015)
# are live in the SAME real-Kodi DTS passthrough run. Read-only.
P=/proc/utopia_mdb/audio
OUT=/data/local/tmp/r30r_dts_dec
mkdir -p $OUT
CAPLOG=$OUT/cap.log
echo "R30R_COMBINED START dts file=/storage/emulated/0/Movies/test_dts_51.mp4" > $CAPLOG
date >> $CAPLOG

sample() {
  # $1=label $2=addr $3=len
  dmesg -c >/dev/null 2>&1
  echo read_dsp_sram_type=1 addr=$2 len=$3 > $P
  sleep 0.45
  echo "=== $1 ===" >> $OUT/dm.txt
  dmesg | grep 'DM\[' >> $OUT/dm.txt
}

# launch real Kodi passthrough of DTS file
am start -n net.kodinerds.maven.kodi22/.Splash -d "file:///storage/emulated/0/Movies/test_dts_51.mp4" >> $CAPLOG 2>&1
echo "LAUNCHED" >> $CAPLOG
sleep 6

# sample during steady playback: DEC region + gate inputs
sample DEC_STEADY1 0x0fe0 0xf1
sample GATE_STEADY1 0x0c00 0x30
sample W1_GATE 0x0010 0x10
sample W2_OUT 0x0840 0x40

sleep 4
sample DEC_STEADY2 0x0fe0 0xf1
sample GATE_STEADY2 0x0c00 0x30

# stop
am force-stop net.kodinerds.maven.kodi22 >> $CAPLOG 2>&1
echo "R30R_COMBINED DONE dts" >> $CAPLOG
date >> $CAPLOG
echo "captured to $OUT"
