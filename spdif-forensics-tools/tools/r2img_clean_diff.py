import re, sys

NAMES = ['mst_codec_r2', 'mst_codec_r2_MS12V22', 'mst_snd_r2', 'mst_snd_r2_MS12V22']
data = {n: open(f'r2img/{n}.bin', 'rb').read() for n in NAMES}
strs = {n: set(m.group().decode('latin-1') for m in re.finditer(rb'[\x20-\x7e]{8,}', data[n]))
        for n in NAMES}

def keep(s):
    sl = s.lower()
    if len(s) < 8: return False
    keys = ['ms12', 'ddp', 'dd+', 'dolby', 'ac4', 'mat', 'truehd', 'mlp', 'atmos', 'joc',
            'dts', 'xma', 'xpt', 'mqa', 'opus', 'aac', 'he-aac', 'sbr', 'ps_', 'lcld',
            'aot', 'oes', 'oam', 'oah', 'qmf', 'sac', 'slh', 'mp4', 'lpcm', 'pcm',
            'iec61937', 'sdo', 'spdif', 'hdmi', 'arc', 'earc', 'nonpcm', 'bypass',
            'file_player', 'file-player', 'xcoder', 'xpt', 'mat', 'ddp_',
            'transform', 'tr_encode', 'trx', 'trs', 'trX', 'sdo_packer',
            'dts-hd', 'dca', 'lcld', 'lossless', 'ddp_ddplus', 'joc_decode',
            'xpt_dts', 'xch', 'xfp', 'xqma', 'xlpd', 'decoder', 'encode',
            'dtsx', 'd2a_', 'm_aenc', 'm_dec', 'm_enc', 'ms12v22', 'ms12v1',
            'compr', 'decompr', 'low_lat', 'ddpms', 'xpt', 'xfp', 'dla']
    return any(k in sl for k in keys)

def show(a, b):
    only_a = sorted(x for x in strs[a] - strs[b] if keep(x))
    only_b = sorted(x for x in strs[b] - strs[a] if keep(x))
    print(f"\n==== {a} ONLY ({len(only_a)}) vs {b} ONLY ({len(only_b)}) ====")
    for s in only_a: print(f"   -A-  {s[:120]}")
    for s in only_b: print(f"   -B-  {s[:120]}")

show('mst_codec_r2', 'mst_codec_r2_MS12V22')
show('mst_snd_r2', 'mst_snd_r2_MS12V22')
