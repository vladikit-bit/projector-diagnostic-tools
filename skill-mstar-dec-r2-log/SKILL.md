---
name: mstar-dec-r2-log
description: Capture and interpret MStar AEON DEC/SND R2 runtime logs and DSP SRAM (DM/PM) on MStar Android STB/TV (e.g. MT5889, MT589X) for audio passthrough / codec / license forensics. Use when investigating why a codec (DTS/AC3/etc) fails to passthrough over SPDIF/HDMI, or when reading DEC/SND DM/PM via /proc/utopia_mdb/audio.
---

# MStar DEC/SND R2 runtime log + DSP SRAM capture (audio forensics)

Reusable method for runtime investigation of MStar audio on Android STB/TV. Derived from a
multi-phase forensic session (TD98 Pro / C50A, MT5889, Android 11, kernel 4.19.116) where
DTS bitstream passthrough over SPDIF failed while AC3 worked.

## 1. ADB over TCP (userdebug) — daemon state is NOT persistent
On this class of device the `adb` daemon (re)starts between separate shell invocations and TCP
drops after `adb root`. Always re-connect (and re-root if needed) on EVERY call. Put this in a
wrapper `r16_adb.sh` and call `bash r16_adb.sh shell "..."`:

```
#!/bin/bash
A=/c/Android/platform-tools-latest-windows/platform-tools/adb.exe   # absolute path; bare 'adb' is NOT on PATH
DEV=192.168.0.183:5555
"$A" start-server >/dev/null 2>&1
"$A" connect "$DEV" >/dev/null 2>&1
sleep 1
who=$("$A" shell id 2>/dev/null | head -1)
case "$who" in *root*) ;; *) "$A" root >/dev/null 2>&1; sleep 3; "$A" connect "$DEV" >/dev/null 2>&1; sleep 1 ;; esac
exec "$A" "$@"
```

## 2. DEC vs SND R2 runtime log capture  (/proc/utopia_mdb/audio)
Legacy default log path is `/tmp`; force `/data` with `PATH=1`. The decoder selector is the FIRST
number: `dump_r2_log_start=0` = **DEC** log, `=1` = **SND** log.

Fresh DEC log to /data (verified working):
```
echo stop_dump_r2_log > /proc/utopia_mdb/audio
echo dump_r2_log_stop=0 > /proc/utopia_mdb/audio
rm -f /data/AudioDECR2_*                      # guarantee a FRESH file
echo 'dump_r2_log_start=0 9E=0x16 PATH=1 8A=0x1' > /proc/utopia_mdb/audio
sleep 2
# verify file exists, THEN start playback
```
- `9E=0x16 PATH=1 8A=0x1` are device/instance params found by grepping the audio kmod strings
  (`kmods/utpa2k_*.ko`): look for `dump_r2_log_start=0 9E=... PATH=... 8A=...` and
  `PATH: dump file path: 0:/tmp 1:/data`.
- File: `/data/AudioDECR2_9E0x16_8A0x1_880x0_01.log` (suffix auto-increments per run).
- Stop: `echo dump_r2_log_stop=0 > /proc/utopia_mdb/audio; echo stop_dump_r2_log > /proc/utopia_mdb/audio`.

## 3. Playback injection (raw file, bypasses Android audio policy)
```
CLASSPATH=/data/local/tmp/probe7.jar app_process /system/bin --nice-name=probe7 Probe7 \
   /data/local/tmp/ac3_51.raw ac3raw ac3 2      # ac3
# dts: /data/local/tmp/dts_51.raw dtsraw dts 1
```
Run in background, sleep N, then `kill`/`pkill -f Probe7`, then stop dump.

## 4. RO rootfs: writable /tmp via tmpfs (do NOT leave rootfs RW)
```
mount -o remount,rw / ; mkdir -p /tmp ; mount -t tmpfs tmpfs /tmp ; mount -o remount,ro /
```
Restore: `umount -l /tmp` (lazy — the tmpfs is often busy-held by the audio R2-logger's stale
`/tmp` handle; normal `umount` returns "Device or resource busy"). Confirm rootfs `ro` via
`cat /proc/mounts | grep ' / '`. Leave the empty `/tmp` dir (can't rmdir on ro rootfs).

## 5. Reading DEC/SND DM/PM via /proc/utopia_mdb/audio
```
echo "read_dsp_sram_type=1 addr=0x0A00 len=0x40" > /proc/utopia_mdb/audio   # DM (1) / PM (0)
sleep 0.5 ; dmesg | grep 'DM\['
```
**CRITICAL LIMITATION:** the debug interface truncates the address to 16 bits, so only the
**DEC** DM window `0x0000–0xFFFF` is reachable. The **SND** DM (higher window) is UNREACHABLE
from the DEC-side read. Do not waste time trying to read SND DM this way.

## 6. How to READ the DEC R2 log (key semantics)
- Periodic status line: `[NNNNNNNN]ES=xxxx(yyyy),PCM=zzzz|type<81> cmd<4>|play=N...state=S...`
  - `type<81>` = passthrough / IEC61937-pack path. `type<4>` = PCM-decode path.
  - Frame-decode line: `LvL<...> Frm:[a]->[b] pcm:NNNN es:MMM cB:KKK`
    - `es:1536 cB:600` = compressed IEC61937 burst produced (PASSTHROUGH working).
    - `es:0 cB:0` = PCM only, NO burst. `pcm:5120` = PCM-decode output.
- Decoder (re)select / fallback:
  `r2_decoder_houseKeeping: dec_id:0, decType change !! type[81] -> type[4] !!`
  `r2_decoder_select: dec:0, decType:0x4`
  `dts m6 hook ok` / `dts m6 init ok, dts_licensee=0, lbr_licensee=0, xll_licensee=0, transcoder_licensee=0`
  → DTS fell back from passthrough (0x81, es:1536) to PCM (0x4, es:0). `licensee=0` is a
    reported STATUS, not a self-proving causal string. AC3 instead does
    `type[4] -> type[81]` + `CPU MS12V2 ddp init ok` and stays 0x81 (es:1536 throughout).
- The DEC R2 log does NOT contain literal `spdif`/`Invalid`/`output_spdifSz`/`Packer`/`SDO`/
  `Hdmi` strings — those live on the SND/output stage. The DEC `es:1536` is *intent*; the actual
  `Pa=F872` write to DM 0x0A00 is done by the SND packer (unobserved). So a DEC-level `es:0`
  fallback explains "DM 0x0900-0x0C00 never written" but the precise license gate is SND-side.

## 7. Constraints (forensic, read-only)
No DM/PM writes, no binary patches, no EDID/routing/settings changes, no module replacement,
no reboot, no full 64K dump, no full PM ISA decode. Snapshot/compare only.

## 8. Gotchas
- The DTS DEC R2 log is **ring-buffered at the top** (starts at frame ~108, not 0). Use the
  decoder state-machine messages (decType change / init / dec play) for ordering, not raw line #.
- `dump_r2_log_start=1` (SND) was the initial wrong guess — it only creates `/tmp/AudioSNDR2_*`
  and leaves a busy `/tmp` handle. Use `=0` for DEC.
- Cleaned message extraction: `grep -nvE '^\[[0-9]+\]ES=|LvL<|^(cpt|pt)=' log > msgs.txt`
