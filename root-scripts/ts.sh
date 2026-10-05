#!/system/bin/sh
F=$1; N=$2
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rpc Stop 80 "$F" >/dev/null 2>&1; sleep 4
rpc Open 81 "$F" >/dev/null 2>&1
i=0
while [ $i -lt $N ]; do
  sleep 4
  dmesg -c >/dev/null 2>&1; echo audio_status > $P; sleep 1.5
  A=$(dmesg | sed -E 's/^\[[^]]*\] //' | grep -aE '^\[1st decoder\]|^DecStatus|^UnSupportType' | tr '\n' ' ')
  dmesg -c >/dev/null 2>&1; echo reg_bank=0x112E > $P; sleep 1
  B=$(dmesg | grep -a " | " | head -1 | grep -oE '0000 84[0-9A-F]{2}|0000 04[0-9A-F]{2}')
  echo "  t=$((i*4+6))s  $A  bank:$B"
  i=$((i+1))
done
rpc Stop 82 "$F" >/dev/null 2>&1
