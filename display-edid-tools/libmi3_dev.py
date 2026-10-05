import re
PATH = r"c:/firmware_temp/spdif_audio_investigation/libs/libmi3.so"
data = open(PATH,'rb').read()
print("=== /dev strings in libmi3.so ===")
for m in re.finditer(rb"/dev/[\x20-\x7e]{1,30}", data):
    print(hex(m.start()), m.group().decode())
print("=== 'mi_disp' / 'mi_' / 'disp' device-ish substrings ===")
for m in re.finditer(rb"mi[_-]?disp[\x20-\x7e]{0,12}", data):
    print(hex(m.start()), m.group().decode())
print("=== any string containing 'open' near device (scan all /dev) done ===")
# Also: look for the ioctl wrapper MI_DISP_SetOutputTiming context (the cmd constant region)
i = data.find(b"MI_DEV_IOC_DISP_SET_OUTPUT_TIMING")
print("literal at", hex(i))
# surrounding bytes (the function likely has the numeric cmd too); dump 200 bytes before
lo=max(0,i-200)
chunk=data[lo:i+40]
for off in range(0,len(chunk),16):
    seg=chunk[off:off+16]
    hx=" ".join("%02x"%b for b in seg)
    asc="".join(chr(b) if 32<=b<127 else "." for b in seg)
    print("%08x  %-47s  %s"%(lo+off,hx,asc))
