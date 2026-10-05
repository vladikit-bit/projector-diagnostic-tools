#!/system/bin/sh
OUT=$1; shift
P=/proc/utopia_mdb/audio
: > $OUT
for b in "$@"; do
  dmesg -c >/dev/null 2>&1
  echo "reg_bank=0x$b" > $P
  sleep 0.6
  echo "@@@ BANK $b" >> $OUT
  dmesg | grep -a " | " >> $OUT
done
