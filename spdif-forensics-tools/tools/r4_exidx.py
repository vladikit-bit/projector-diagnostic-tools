from elftools.elf.elffile import ELFFile
import struct
LIB="libs/libutopia.so"
f=open(LIB,'rb'); elf=ELFFile(f)
ex=elf.get_section_by_name('.ARM.exidx')
fnstarts=[]
if ex:
    data=ex.data(); base=ex['sh_addr']
    for i in range(len(data)//8):
        w0=struct.unpack_from('<I', data, i*8)[0]
        waddr=base+i*8
        if w0==0: continue
        off=w0 & 0x7fffffff
        if off & 0x40000000: off-=0x80000000
        fnstarts.append((waddr+off)&0xffffffff)
fnstarts=sorted(set(fnstarts))
print("exidx fn count:",len(fnstarts))
def func_of(va):
    lo,hi,best=0,len(fnstarts)-1,None
    while lo<=hi:
        mid=(lo+hi)//2
        if fnstarts[mid]<=va: best=fnstarts[mid]; lo=mid+1
        else: hi=mid-1
    return best
targets={
 "SPDIF out codec prev":0x1656ca,
 "Hash Key DTSX Fail":0x165546,
 "eDigitalOutfMode":0x1a7700,
 "Fail switch SPDIF":0x1ad63e,
 "HAL SPDIF Non-PCM":0x17d9cc,
 "HAL SPDIF PCM":0x147653,
 "Hash-key Support DTSX":0x1acf12,
 "Tx_NonPCM":0x1a74c8,
 "SPDIF mode set to":0x1b8d53,
 "Invalid SPDIF Path":0x16b49b,
 "DTSXEncode cur":0x13b6f5,
 "R2NonPcmSetting":0x1a7738,
}
res={}
for k,va in sorted(targets.items(), key=lambda x:x[1]):
    s=func_of(va)
    if s is None:
        print(f"{k:24s} va={va:08x}  NO enclosing fn"); continue
    idx=fnstarts.index(s)
    nxt=fnstarts[idx+1] if idx+1<len(fnstarts) else (s+0x2000)
    print(f"{k:24s} va={va:08x}  fn={s:08x}..{nxt:08x} size~{nxt-s:#x}")
    res.setdefault(s,[]).append(k)
print("\n== GROUPED ==")
for s,ks in sorted(res.items()):
    print(f"fn {s:08x}: {ks}")
