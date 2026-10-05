#!/system/bin/sh
F=$1; L=$2
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rm -f /data/DUMP_audio*PCM*.bin /data/DUMP_ES1*.bin
rpc Stop 110 "$F" >/dev/null 2>&1; sleep 4
rpc Open 111 "$F" >/dev/null 2>&1
sleep 2
echo "dump_pcm=1 path=1" > $P ; echo "dump_es=1 path=1" > $P
sleep 10
echo "dump_pcm=0 path=1" > $P ; echo "dump_es=0 path=1" > $P
sleep 2
echo "$L:"; ls -l /data/DUMP_audio*PCM*.bin /data/DUMP_ES1*.bin 2>/dev/null | awk '{print "   ",$5,$9}'
rpc Stop 112 "$F" >/dev/null 2>&1
