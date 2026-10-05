#!/system/bin/sh
# usage: round.sh <file.mp4> <label>
F=$1; L=$2
rpc(){ printf '{"jsonrpc":"2.0","method":"%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
rpc Stop 60 "$F" >/dev/null 2>&1; sleep 4
rpc Open 61 "$F" >/dev/null 2>&1; sleep 11
dmesg -c >/dev/null 2>&1; echo show_all_decoder_status > /proc/utopia_mdb/audio; sleep 2
D0=$(dmesg | grep -aE "Decoder (ID|format|play state)" | tail -15 | head -3 | sed -E 's/.*(Decoder [^:]*): *//' | tr '\n' '/')
dmesg -c >/dev/null 2>&1; echo audio_status > /proc/utopia_mdb/audio; sleep 2
A=$(dmesg | sed -E 's/^\[[^]]*\] //' | sed -n 's/^\[1st decoder\] type:\(..\), cmd:\(..\).*/type=\1,cmd=\2/p; s/^DecStatus *: ([0-9]).*/DecStatus=\1/p; s/^UnSupportType *: ([0-9]).*/UnSupport=\1/p' | tr '\n' ' ')
NP=$(rm -f /data/DUMP_audio_spdifNpcm_*.bin; echo "dump_spdif_npcm=1 path=1" > /proc/utopia_mdb/audio; sleep 8; echo "dump_spdif_npcm=0 path=1" > /proc/utopia_mdb/audio; sleep 2; ls -l /data/DUMP_audio_spdifNpcm_*.bin 2>/dev/null | awk '{print $5}')
echo "$L | dec0[$D0] | $A | npcm=${NP:-none}B"
