#!/system/bin/sh
P=/proc/utopia_mdb/audio
echo "debug_level=5" > $P
dmesg -c >/dev/null 2>&1
dmesg -w > /data/local/tmp/scan.txt 2>/dev/null &
DP=$!
sleep 1
i=0
while [ $i -lt 256 ]; do
  H=$(printf '%02x' $i)
  /data/local/tmp/pwoff run $i 0 0 "$H" >/dev/null 2>&1
  i=$((i+1))
done
sleep 3
kill $DP 2>/dev/null
echo "debug_level=0" > $P
echo "captured $(wc -l < /data/local/tmp/scan.txt) lines"
