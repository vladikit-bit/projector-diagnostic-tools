#!/system/bin/sh
# Small-read DSP-SRAM sweep with completeness verification and retry.
F=$1; L=$2
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rpc Stop 400 "$F" >/dev/null 2>&1; sleep 4
rpc Open 401 "$F" >/dev/null 2>&1; sleep 6
: > /data/local/tmp/sweep_$L.txt
a=0
short=0
while [ $a -lt 65536 ]; do
  h=$(printf '%04X' $a)
  got=0
  try=1
  while [ $try -le 4 ]; do
    dmesg -c >/dev/null 2>&1
    echo "read_dsp_sram_type=1 addr=0x$h len=0x100" > $P
    sleep 1.4
    n=$(dmesg | grep -ac "DM\[0x$h\]")
    got=$n
    [ "$n" -ge 250 ] && break
    try=$((try+1)); sleep 1
  done
  [ "$got" -lt 250 ] && short=$((short+1))
  echo "@@@$h" >> /data/local/tmp/sweep_$L.txt
  dmesg | grep -aoE 'DM\[0x[0-9a-fA-F]+\] = 0x[0-9a-fA-F]+' >> /data/local/tmp/sweep_$L.txt
  a=$((a+256))
done
echo "SWEEP $L DONE short_blocks=$short"
rpc Stop 402 "$F" >/dev/null 2>&1
