#!/system/bin/sh
# R23-A wide matched-state DM capture for DTS-over-SPDIF IEC config localization.
# READ-ONLY. Dumps the FULL SND DM (cell 0x0000..0x10000) during fresh, IEC-active
# DTS and AC3 passthrough, then a stop/idle dump. Diff at matched IEC-active state
# to find the DTS packer's IEC config register.
#
# Usage (device, as root via adb):
#   adb connect 192.168.0.183:5555
#   adb push r23_cap.sh /data/local/tmp/
#   adb shell "sh /data/local/tmp/r23_cap.sh" &
#   (then start a FRESH DTS passthrough track in Kodi; script auto-detects;
#    stop it, then start a FRESH AC3 passthrough track; script auto-detects)
#
# Output: /data/local/tmp/r23_<codec>_active.txt and /data/local/tmp/r23_<codec>_idle.txt
set -u
PROC=/proc/utopia_mdb/audio
OUT=/data/local/tmp

# full DM dump: 128 reads of 512 cells (0x200), cell-indexed addr 0..0xFF00
full_dump() {
  local tag="$1"
  local F="$OUT/r23_${tag}.txt"
  : > "$F"
  local a=0
  while [ $a -lt 65536 ]; do
    dmesg -c > /dev/null 2>&1
    echo "read_dsp_sram_type=1 addr=$a len=0x200" > "$PROC"
    sleep 0.35
    dmesg | grep -a 'DM\[' >> "$F"
    a=$((a + 512))
  done
  echo "  [full_dump $tag] wrote $F ($(wc -l < "$F") lines)"
}

# read one cell (cell-indexed). returns value via stdout.
read_cell() {
  local a="$1"
  dmesg -c > /dev/null 2>&1
  echo "read_dsp_sram_type=1 addr=$a len=1" > "$PROC"
  sleep 0.25
  dmesg | grep -a "DM\[0x$(printf '%x' $a)\]" | head -1 | sed -E 's/.*= 0x([0-9a-fA-F]+).*/\1/'
}

# capture one codec: idle baseline, wait for IEC-active (0x0900 != 0), full active dump, wait idle, full idle dump
capture_codec() {
  local codec="$1"
  echo "=== R23 capture for $codec ==="
  # idle baseline
  full_dump "${codec}_idle"
  echo "  waiting for fresh $codec playback (IEC-active = 0x0900 != 0)..."
  local v=0
  while [ "$v" = "0" ] || [ -z "$v" ]; do
    v=$(read_cell 0x900)
    sleep 1
  done
  echo "  [detected $codec IEC-active 0x0900=0x$v] capturing full active DM..."
  full_dump "${codec}_active"
  echo "  waiting for $codec stop (0x0900 back to 0)..."
  while [ "$v" != "0" ] && [ -n "$v" ]; do
    v=$(read_cell 0x900)
    sleep 1
  done
  echo "=== done $codec ==="
}

# continuous kernel log (open-time events survive per-sample dmesg -c)
dmesg -c >/dev/null 2>&1
dmesg -w > "$OUT/r23_kernfull.txt" 2>/dev/null &
KPID=$!

capture_codec dts
capture_codec ac3

kill $KPID 2>/dev/null
echo "ALL DONE. Pull: adb pull /data/local/tmp/r23_*.txt ."
