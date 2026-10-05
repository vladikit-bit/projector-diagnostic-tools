#!/system/bin/sh
# start the npcm dump EARLY, inside the playback window
F=$1; L=$2; DELAY=$3
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rm -f /data/DUMP_audio_spdifNpcm_*.bin /data/DUMP_ES1_from_DDR_*.bin
rpc Stop 90 "$F" >/dev/null 2>&1; sleep 4
rpc Open 91 "$F" >/dev/null 2>&1
sleep $DELAY
echo "dump_spdif_npcm=1 path=1" > $P
echo "dump_es=1 path=1" > $P
sleep 11
echo "dump_spdif_npcm=0 path=1" > $P
echo "dump_es=0 path=1" > $P
sleep 2
NP=$(ls -l /data/DUMP_audio_spdifNpcm_*.bin 2>/dev/null | awk '{print $5}')
ES=$(ls -l /data/DUMP_ES1_from_DDR_*.bin 2>/dev/null | awk '{print $5}')
echo "$L  start+${DELAY}s -> npcm=${NP:-0}B  es=${ES:-0}B"
rpc Stop 92 "$F" >/dev/null 2>&1
