import sys, os, re
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import ArmFunc, attach
from relocs import Relocs
import capstone
KO='kmods/mik.ko'
e=ELF32(KO); attach(e); rl=Relocs(e)

# 1) Find MApi_AUDIO_SPDIF_SetMode + EDID-related symbols
print("=== symbols of interest ===")
for s in e.syms:
    nm=s.get('name','')
    if any(k in nm for k in ['SPDIF_SetMode','SetHdmiAutoMode','ParseEdid','SetDigitalMode',
                              'SetDigitalChannel','EDID','HdmiInfo','AutoMode']):
        print(f"  {nm} @ {hex(s['value'])}")

# 2) Full .text scan: callers of MApi_AUDIO_SPDIF_SetMode + field writes to SPDIF-mode offsets
target=None
for s in e.syms:
    if s.get('name')=='MApi_AUDIO_SPDIF_SetMode':
        target=s['value']
print(f"\nMApi_AUDIO_SPDIF_SetMode @ {hex(target) if target else 'NOT FOUND'}")

text=e.sec('.text')
data=e.b[text['off']:text['off']+text['size']]
base=text['addr']
md=capstone.Cs(capstone.CS_ARCH_ARM, capstone.CS_MODE_ARM+capstone.CS_MODE_LITTLE_ENDIAN)
md.detail=True
callers=[]
field_hits=[]
MODE_OFFS={0x6c,0x70,0x7c,0x80,0x4d8}
for ins in md.disasm(data, base):
    if ins.mnemonic in ('bl','blx'):
        # parse absolute target from op_str
        m=re.search(r'#0x([0-9a-fA-F]+)', ins.op_str)
        if m and target is not None and int(m.group(1),16)==target:
            callers.append(ins.address)
    if ins.mnemonic in ('str','strb','ldr','ldrb'):
        # find immediate offset operand like [#0x7c]
        for op in ins.op_str.split(','):
            op=op.strip()
            mm=re.search(r'#0x([0-9a-fA-F]+)\]$', op)
            if mm and int(mm.group(1),16) in MODE_OFFS:
                field_hits.append((ins.address, ins.mnemonic+' '+ins.op_str))
                break
print(f"\n=== direct bl callers of MApi_AUDIO_SPDIF_SetMode ({len(callers)}) ===")
for c in callers: print(f"  0x{c:08x}")
print(f"\n=== mik.ko field writes/reads to mode offsets {[hex(x) for x in sorted(MODE_OFFS)]} ({len(field_hits)}) ===")
for va,s in field_hits[:120]:
    print(f"  0x{va:08x}: {s}")
