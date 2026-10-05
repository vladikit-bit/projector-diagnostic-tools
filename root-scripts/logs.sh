#!/system/bin/sh
F=$1
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
dmesg -c >/dev/null 2>&1
rpc Stop 95 "$F" >/dev/null 2>&1; sleep 4
rpc Open 96 "$F" >/dev/null 2>&1
sleep 14
dmesg > /data/local/tmp/dts_dmesg.txt
echo "--- dmesg lines mentioning spdif/licen/otp/dts ---"
grep -aiE "spdif|licen|otp|invalid" /data/local/tmp/dts_dmesg.txt | head -20
echo "--- total dmesg lines captured: $(wc -l < /data/local/tmp/dts_dmesg.txt) ---"
rpc Stop 97 "$F" >/dev/null 2>&1
