#!/system/bin/sh
F=$1; L=$2
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rpc Stop 300 "$F" >/dev/null 2>&1; sleep 4
rpc Open 301 "$F" >/dev/null 2>&1; sleep 5
: > /data/local/tmp/full_$L.txt
a=0
while [ $a -lt 65536 ]; do
  h=$(printf '%04X' $a)
  dmesg -c >/dev/null 2>&1
  echo "read_dsp_sram_type=1 addr=0x$h len=0x4000" > $P
  sleep 1.1
  echo "@@@$h" >> /data/local/tmp/full_$L.txt
  dmesg | grep -aoE 'DM\[0x[0-9a-fA-F]+\] = 0x[0-9a-fA-F]+' >> /data/local/tmp/full_$L.txt
  a=$((a+4096))
done
echo "full sweep $L done: $(grep -ac 'DM\[' /data/local/tmp/full_$L.txt) cells"
rpc Stop 302 "$F" >/dev/null 2>&1
