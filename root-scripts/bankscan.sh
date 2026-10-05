#!/system/bin/sh
P=/proc/utopia_mdb/audio
for b in "$@"; do
  dmesg -c >/dev/null 2>&1; echo "reg_bank=0x$b" > $P; sleep 0.6
  L=$(dmesg | tail -2)
  NZ=$(echo "$L" | tr -d ' \x0a' | tr '|' '\n' | tr -d '0123456789ABCDEF' | wc -c)
  SUM=$(echo "$L" | sed -n 's/.*\] \(.*\)/\1/p' | tr -cd '0-9A-F' | tr 'A-F' 'a-f')
  echo "BANK $b $SUM"
done
