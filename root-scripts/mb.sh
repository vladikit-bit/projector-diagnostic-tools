#!/system/bin/sh
# mailbox test: fire cmd 144 sub-commands 6..14 DURING verified DTS playback
P=/proc/utopia_mdb/audio
F=test_dts_51.mp4
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rm -f /data/DUMP_audio_spdifNpcm_*.bin /data/DUMP_ES1_from_DDR_*.bin
rpc Stop 100 "$F" >/dev/null 2>&1; sleep 4
rpc Open 101 "$F" >/dev/null 2>&1
sleep 3
echo "dump_spdif_npcm=1 path=1" > $P ; echo "dump_es=1 path=1" > $P
for n in 6 7 8 9 A B C D E; do
  /data/local/tmp/pwoff run 144 0 1 "000${n}00000001000000" 2>&1 | sed -n '1p' | sed "s/^/  sub=$n /"
  sleep 1
done
sleep 8
echo "dump_spdif_npcm=0 path=1" > $P ; echo "dump_es=0 path=1" > $P
sleep 2
NP=$(ls -l /data/DUMP_audio_spdifNpcm_*.bin 2>/dev/null | awk '{print $5}')
ES=$(ls -l /data/DUMP_ES1_from_DDR_*.bin 2>/dev/null | awk '{print $5}')
dmesg -c >/dev/null 2>&1; echo audio_status > $P; sleep 2
ST=$(dmesg | sed -E 's/^\[[^]]*\] //' | grep -aE '^\[1st decoder\]|^DecStatus' | tr '\n' ' ')
echo "RESULT after 9 sub-commands: npcm=${NP:-0}B es=${ES:-0}B  $ST"
rpc Stop 102 "$F" >/dev/null 2>&1
