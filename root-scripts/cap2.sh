#!/system/bin/sh
# continuous kernel capture across device open + playback
F=$1; L=$2
P=/proc/utopia_mdb/audio
O=/data/local/tmp/cap2_$L.txt
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rpc Stop 220 "$F" >/dev/null 2>&1; sleep 5
echo "debug_level=5" > $P
: > $O
dmesg -w >> $O 2>/dev/null &
DPID=$!
sleep 1
rpc Open 221 "$F" >/dev/null 2>&1
sleep 12
kill $DPID 2>/dev/null
echo "debug_level=0" > $P
echo "== $L : $(wc -l < $O) lines =="
echo -n "   OutputType/OutputMode hits: "
grep -acE "(SetSpdifOutputType|SetSpdifOutputMode|SetHdmiArcOutputType|SetHdmiTxOutputMode|SetHdmiTxOutputType)" $O
grep -aoE "\[Set[A-Za-z]*Output(Type|Mode) = ?[0-9a-fx]*\]?" $O | sort | uniq -c
echo "   other 'connect' evidence:"
grep -aoE "\[[A-Za-z]*connect[A-Za-z ]*\]" $O | sort | uniq -c | head -5
rpc Stop 222 "$F" >/dev/null 2>&1
