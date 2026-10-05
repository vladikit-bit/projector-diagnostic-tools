import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import ArmFunc, attach
from relocs import Relocs
KO='kmods/utpa2k.ko'
e=ELF32(KO); attach(e); rl=Relocs(e)

def dump(va,size,name,highlight=None):
    f=ArmFunc(e,va,name=name,size=size)
    print(f"\n=== {name} @0x{va:x} (size 0x{size:x}) ===")
    for i in f.insns:
        s=f"{i.mnemonic} {i.op_str}"
        extra=''
        if i.mnemonic in ('bl','blx'):
            t=rl.call_target(i.address)
            if t: extra=f"   ; -> {t}"
        if highlight is None or any(h in s for h in highlight):
            print(f"0x{i.address:08x}: {s}{extra}")

# OBJ 1: decoder-start path
dump(0x405cc8,0x200,'MDrv_AUDIO_OpenDecodeSystem')
dump(0x424b90,0x200,'MDrv_AUDIO_ApplyHashkey')
dump(0x44b51c,0x340,'HAL_AUDIO_HDMI_SetNonpcm',['0x4d8','0x4d0','0x444','SetMode','str','blx','tst'])
dump(0x44cf8,0x180,'HAL_AUDIO_SPDIF_AutoMode',['0x582','str','blx','tst','mov','cmp'])
dump(0x45330,0x180,'HAL_AUDIO_SPDIF_BypassMode',['0x582','str','blx','tst','mov','cmp'])
dump(0x45c00,0x180,'HAL_AUDIO_SPDIF_TranscodeMode',['0x582','str','blx','tst','mov','cmp'])
dump(0x46168,0x180,'HAL_AUDIO_DigitalTx_ApplySetting',['0x582','str','blx','tst','mov','cmp'])

# SetSystem2: resolve DSP-write call target
f=ArmFunc(e,0x44d0b0,name='SetSystem2',size=0x360)
print("\n=== SetSystem2 call targets (0x44d0b0) ===")
for i in f.insns:
    if i.mnemonic in ('bl','blx'):
        t=rl.call_target(i.address)
        if t: print(f"0x{i.address:08x}: bl -> {t}")

# Callers of key funcs (by_target)
print("\n=== callers by_target ===")
for tgt in ['MDrv_AUDIO_SetDecodeSystem','MDrv_AUDIO_OpenDecodeSystem','MDrv_AUDIO_ApplyHashkey',
            'HAL_AUDIO_SPDIF_AutoMode','HAL_AUDIO_SPDIF_BypassMode','HAL_AUDIO_SPDIF_TranscodeMode',
            'HAL_AUDIO_DigitalTx_ApplySetting','HAL_AUDIO_HDMI_SetNonpcm','HAL_MAD_SetAudioParam2']:
    sites=rl.by_target.get(tgt,[])
    print(f"{tgt}: {sites}")
