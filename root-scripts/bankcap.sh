#!/system/bin/sh
# Bank capture + decoder status for one tag. READ-ONLY.
TAG=$1
P=/proc/utopia_mdb/audio
echo "### $TAG spdif_mode"
dmesg -c >/dev/null 2>&1; echo spdif_mode > $P; sleep 1; dmesg | sed -n '1p'
echo "### $TAG decoder"
dmesg -c >/dev/null 2>&1; echo show_all_decoder_status > $P; sleep 2
dmesg | grep -aE "Decoder (ID|format|play state)" | tail -15
echo "### $TAG banks"
for b in 1128 1129 112A 112B 112C 112D 112E 112F; do
  dmesg -c >/dev/null 2>&1; echo "reg_bank=0x$b" > $P; sleep 1
  echo -n "BANK $b "; dmesg | sed -n '2p'
done
