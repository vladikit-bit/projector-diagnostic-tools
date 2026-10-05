#!/system/bin/sh
F=test_dts_51.mp4
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rpc Stop 240 "$F" >/dev/null 2>&1; sleep 4
echo "debug_level=5" > $P
dmesg -c >/dev/null 2>&1
dmesg -w > /data/local/tmp/st3.txt 2>/dev/null &
DP=$!
rpc Open 241 "$F" >/dev/null 2>&1
sleep 6
echo "--- pwoff cmd 224 with the text block ---"
/data/local/tmp/pwoff run 224 0 1 "53657453706469664f7574707574547970653d445453"
sleep 5
kill $DP 2>/dev/null
echo "debug_level=0" > $P
echo "=== OutputType/OutputMode log hits ==="
grep -aoE "\[Set[A-Za-z]*Output(Type|Mode) = ?[0-9a-fx]*\]?" /data/local/tmp/st3.txt | sort | uniq -c
echo "  (lines: $(wc -l < /data/local/tmp/st3.txt))"
rpc Stop 242 "$F" >/dev/null 2>&1
