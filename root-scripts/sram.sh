#!/system/bin/sh
# sample a spread of DSP SRAM cells while a stream plays
F=$1; L=$2
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rpc Stop 240 "$F" >/dev/null 2>&1; sleep 4
rpc Open 241 "$F" >/dev/null 2>&1; sleep 4
: > /data/local/tmp/sram_$L.txt
for a in 0x0000 0x0100 0x0400 0x0800 0x0C00 0x1000 0x1800 0x1E00 0x1E10 0x1E14 0x1E18 0x1E1C 0x1E20 0x1E30 0x1E40 0x1E80 0x1F00 0x2000; do
  dmesg -c >/dev/null 2>&1
  echo "read_dsp_sram_type=1 addr=$a len=8" > $P
  sleep 0.35
  echo -n "$a " >> /data/local/tmp/sram_$L.txt
  dmesg | grep -aoE 'DM\[0x[0-9a-fA-F]+\] = 0x[0-9a-fA-F]+' | tr '\n' ' ' >> /data/local/tmp/sram_$L.txt
  echo "" >> /data/local/tmp/sram_$L.txt
done
rpc Stop 242 "$F" >/dev/null 2>&1
echo "sampled $L"
