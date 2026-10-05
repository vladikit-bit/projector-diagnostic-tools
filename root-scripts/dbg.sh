#!/system/bin/sh
F=$1; L=$2
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
echo "debug_level=5" > $P
dmesg -c >/dev/null 2>&1
rpc Stop 210 "$F" >/dev/null 2>&1; sleep 4
rpc Open 211 "$F" >/dev/null 2>&1; sleep 7
dmesg > /data/local/tmp/dbg_$L.txt
echo "== $L =="
grep -aoE "\[(SetSpdifOutputType|SetSpdifOutputMode|SetHdmiArcOutputType|SetHdmiTxOutputType) = ?[0-9a-fx]*\]?" /data/local/tmp/dbg_$L.txt | sort | uniq -c
grep -acE "SetSpdifOutputType" /data/local/tmp/dbg_$L.txt | sed 's/^/  raw SetSpdifOutputType lines: /'
rpc Stop 212 "$F" >/dev/null 2>&1
echo "debug_level=0" > $P
