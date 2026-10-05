#!/system/bin/sh
F=test_dts_51.mp4
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rpc Stop 230 "$F" >/dev/null 2>&1; sleep 4
echo "debug_level=5" > $P
dmesg -c >/dev/null 2>&1
dmesg -w > /data/local/tmp/st2.txt 2>/dev/null &
DP=$!
rpc Open 231 "$F" >/dev/null 2>&1
sleep 6
echo "--- calling settype ---"
/data/local/tmp/settype "SetSpdifOutputType=DTS" 1
sleep 5
kill $DP 2>/dev/null
echo "debug_level=0" > $P
echo "=== log hits ==="
grep -aoE "\[Set[A-Za-z]*Output(Type|Mode) = ?[0-9a-fx]*\]?" /data/local/tmp/st2.txt | sort | uniq -c
echo "  (lines: $(wc -l < /data/local/tmp/st2.txt))"
rpc Stop 232 "$F" >/dev/null 2>&1
