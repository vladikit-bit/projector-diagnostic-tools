import struct

PATH = r"c:/firmware_temp/spdif_audio_investigation/libs/libmi3.so"
d = open(PATH,'rb').read()
assert d[:4]==b'\x7fELF'
e_shoff = struct.unpack_from('<I', d, 0x20)[0]
e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', d, 0x2e)
secs=[]
for i in range(e_shnum):
    o=e_shoff+i*e_shentsize
    sh=struct.unpack_from('<10I', d, o)
    secs.append(dict(zip(('name','type','flags','addr','off','size','link','info','align','entsize'), sh)))
shstr=secs[e_shstrndx]
def nm(x):
    s=d[shstr['off']+x:]; return s[:s.index(b'\x00')].decode('utf8','replace')
for s in secs: s['nm']=nm(s['name'])
e_phoff=struct.unpack_from('<I', d, 0x1c)[0]
e_phentsize,e_phnum=struct.unpack_from('<HH', d, 0x2a)
phs=[struct.unpack_from('<8I', d, e_phoff+i*e_phentsize) for i in range(e_phnum)]
def v2f(v):
    for p in phs:
        if p[0]==1 and p[2]<=v<p[2]+p[4]:
            return p[1]+(v-p[2])
    return None
dyn=dynstr=None
for s in secs:
    if s['nm']=='.dynsym': dyn=s
    if s['nm']=='.dynstr': dynstr=s
symtab=[]
for i in range(dyn['size']//16):
    o=dyn['off']+i*16
    st_name,st_value,st_size,st_info,st_other,st_shndx=struct.unpack_from('<IIIBBH', d, o)
    s=d[dynstr['off']+st_name:]; symtab.append((s[:s.index(b'\x00')].decode(),st_value,st_size))
target=[s for s in symtab if s[0]=='MI_DISP_SetOutputTiming']
print("MI_DISP_SetOutputTiming:", target)
for name,va,sz in target:
    fo=v2f(va)
    blob=d[fo:fo+sz]
    print("\n=== %s vaddr=%s size=%d ==="%(name,hex(va),sz))
    consts=set()
    i=0
    while i+4<=len(blob):
        w=struct.unpack_from('<H', blob, i)[0]; w2=struct.unpack_from('<H', blob, i+2)[0] if i+4<=len(blob) else 0
        pc=(fo+i+4)&~3  # aligned PC for literal loads
        # 16-bit LDR Rt,[PC,#imm] : 01001 Rt imm8  -> 0x4800..0x4FFF
        if (w & 0xF800)==0x4800:
            rt=(w>>8)&0x7; imm8=(w&0xFF)*4
            lit=pc+imm8
            foff=v2f(lit)
            if foff is not None and 0<=foff<len(d)-3:
                val=struct.unpack_from('<I', d, foff)[0]
                consts.add(val)
        # 32-bit MOVW (T3): 11110 i0 0 0 0 0 imm3 imm8 ; top half 0xF240..0xF25F ; rt in low half bits15..12
        if (w & 0xFBF0)==0xF240:
            imm8=w2&0xFF; imm3=(w>>10)&0x7; imm4=(w>>12)&0x1
            immlo=imm8|(imm3<<8)|(imm4<<11); rt=w2>>12
            # look for paired MOVT at i+4
            if i+8<=len(blob):
                w3=struct.unpack_from('<H', blob, i+4)[0]; w4=struct.unpack_from('<H', blob, i+6)[0]
                if (w3 & 0xFBF0)==0xF2C0:
                    imm8b=w4&0xFF; imm3b=(w3>>10)&0x7; imm4b=(w3>>12)&0x1
                    immhi=imm8b|(imm3b<<8)|(imm4b<<11)
                    consts.add((immhi<<16)|immlo)
        # 32-bit LDR (literal) T2: 0xF8DF xxxx or 0xF85F xxxx with Rn=PC(0xF)
        if (w & 0xFFF0)==0xF8D0 and (w & 0x000F)==0x000F:
            imm12=((w>>8)&0xF)<<8 | (w2&0xFFF)
            lit=pc+imm12
            foff=v2f(lit)
            if foff is not None and 0<=foff<len(d)-3:
                consts.add(struct.unpack_from('<I', d, foff)[0])
        i+=2
    print("candidate consts (ioctl-like):")
    for c in sorted(consts):
        dirb=(c>>30)&3; size=(c>>16)&0x3FFF; nr=c&0xFF; typ=(c>>8)&0xFF
        if dirb and 0<size<0x3000:
            ch=chr(typ) if 32<=typ<127 else '?'
            print("   %#010x  dir=%d type=%#04x('%c') nr=%d size=%d"%(c,dirb,typ,ch,nr,size))
