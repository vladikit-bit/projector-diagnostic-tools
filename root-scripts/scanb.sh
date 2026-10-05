#!/system/bin/sh
F=$1
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rpc Stop 120 "$F" >/dev/null 2>&1; sleep 4
rpc Open 121 "$F" >/dev/null 2>&1; sleep 4
for b in 112A 112B 1129; do
  dmesg -c >/dev/null 2>&1; echo "reg_bank=0x$b" > $P; sleep 1
  echo "BANK $b"; dmesg | grep -a " | "
done
rpc Stop 122 "$F" >/dev/null 2>&1
