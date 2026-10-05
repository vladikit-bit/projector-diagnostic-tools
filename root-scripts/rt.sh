#!/system/bin/sh
# usage: rt.sh <file> <label>   -- one format, verified, with logcat evidence
F=$1; L=$2
P=/proc/utopia_mdb/audio
rpc(){ printf '{"jsonrpc":"2.0","method":"Player.%s","id":%s,"params":{"item":{"file":"/storage/emulated/0/Movies/%s"}}}' "$1" "$2" "$F" | nc 127.0.0.1 9090; }
logcat -c 2>/dev/null
rpc Stop 70 "$F" >/dev/null 2>&1; sleep 4
rpc Open 71 "$F" >/dev/null 2>&1; sleep 10
PL=$(printf '{"jsonrpc":"2.0","method":"Player.GetActivePlayers","id":72}' | nc 127.0.0.1 9090)
dmesg -c >/dev/null 2>&1; echo show_all_decoder_status > $P; sleep 2
DEC=$(dmesg | grep -aE "Decoder (ID|format|play state)" | tail -15 | head -3 | sed -E 's/.*(Decoder [^:]*): *//' | tr '\n' '/')
dmesg -c >/dev/null 2>&1; echo audio_status > $P; sleep 2
ST=$(dmesg | sed -E 's/^\[[^]]*\] //' | sed -n 's/^\[1st decoder\].*/&/p; s/^DecStatus *: ([0-9]).*/DecStatus=\1/p; s/^UnSupportType *: ([0-9]).*/UnSupport=\1/p' | tr '\n' ' ')
dmesg -c >/dev/null 2>&1; echo reg_bank=0x112E > $P; sleep 1
BANK=$(dmesg | grep -a " | " | head -1 | grep -oE '\| 0000 [0-9A-F ]*')
FR=$(logcat -d 2>/dev/null | grep -c "freerun mode")
FRT=$(logcat -d 2>/dev/null | grep -m3 "freerun mode")
echo "$L | players=${PL##*result*:} | dec0[$DEC] | $ST | bank$E4:$BANK | freerun_hits=$FR $FRT"
rpc Stop 73 "$F" >/dev/null 2>&1
