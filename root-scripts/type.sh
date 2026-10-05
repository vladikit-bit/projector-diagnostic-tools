#!/system/bin/sh
F=$1; L=$2
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rpc Stop 200 "$F" >/dev/null 2>&1; sleep 4
rpc Open 201 "$F" >/dev/null 2>&1; sleep 6
dmesg -c >/dev/null 2>&1; echo spdif_mode > $P; sleep 1
M=$(dmesg | sed -n '1p' | sed -E 's/^\[[^]]*\] //')
A=$(dumpsys media.audio_flinger 2>/dev/null | grep -iE "spdif|arc" | tr -s ' ' | tr '\n' ' ')
echo "$L | $M"
echo "    flinger: $A"
rpc Stop 202 "$F" >/dev/null 2>&1
