import subprocess, struct
ADB=r'C:/Android/platform-tools-latest-windows/platform-tools/adb.exe'
PID='306'
# (VA_start, length) for every /dev/malloc mapping of pid 306
maps=[
 (0xa9993000,0x400000),
 (0xa9d93000,0x400000),
 (0xaa193000,0x180000),
 (0xaa313000,0x5c0000),
 (0xabe13000,0x5c0000),
 (0xad913000,0x3e0000),
 (0xb2147000,0x8c000),
]
sig={0x10C:0x7800,0x118:0x20,0x140:0x1111,0x144:0xC00,0x148:0xC00,0x14C:0xC00}
soff=sorted(sig)
for va,ln in maps:
    skip=va>>12
    cnt=(ln+4095)>>12
    cmd=[ADB,'exec-out','dd if=/proc/%s/mem bs=4096 skip=%d count=%d 2>/dev/null'%(PID,skip,cnt)]
    data=subprocess.run(cmd,capture_output=True).stdout
    full=[]
    partial=[]
    L=len(data)
    for p in range(0,L-0x150,4):
        vals={}
        ok=True
        cntm=0
        for off in soff:
            if p+off+4>L: ok=False;break
            w=struct.unpack_from('<I',data,p+off)[0]
            vals[off]=w
            if w==sig[off]: cntm+=1
            else: ok=False
        if ok: full.append(va+p)
        elif cntm>=4: partial.append((va+p,vals,cntm))
    print('--- VA %08X len=%d read=%d full=%d partial>=4=%d'%(va,ln,L,len(full),len(partial)))
    for c in full: print('   *** SHM_BASE_VA=%08X'%(c))
    for c,vals,cntm in partial[:5]:
        print('   partial@%08X matches=%d vals=%s'%(c,cntm,vals))
