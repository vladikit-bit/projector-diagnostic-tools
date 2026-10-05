#!/system/bin/sh
F=$1; L=$2
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rpc Stop 260 "$F" >/dev/null 2>&1; sleep 4
rpc Open 261 "$F" >/dev/null 2>&1; sleep 5
dmesg -c >/dev/null 2>&1
echo "read_dsp_sram_type=1 addr=0x1058 len=0x10" > $P
sleep 1
echo -n "$L : "
dmesg | grep -aoE 'DM\[0x[0-9a-f]+\] = 0x[0-9a-f]+' | sed 's/DM\[//; s/\] = /=/' | tr '\n' ' '
echo
rpc Stop 262 "$F" >/dev/null 2>&1
