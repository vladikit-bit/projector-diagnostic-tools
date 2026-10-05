import os, re, sys

DTB = '/proc/device-tree'
PC = '/sys/kernel/debug/pinctrl/pinctrl-rockchip-pinctrl/pinconf-pins'
GRF = '/sys/kernel/debug/regmap/dummy-syscon@0x00000000ff100000/registers'

def u32s(b):
    n = len(b) // 4
    return [int.from_bytes(b[i*4:i*4+4], 'big') for i in range(n)]

nodes = {}
phandle_map = {}
for root, dirs, files in os.walk(DTB):
    props = {}
    for fn in files:
        try:
            with open(os.path.join(root, fn), 'rb') as f:
                props[fn] = f.read()
        except Exception:
            props[fn] = b''
    nodes[root] = props
    if 'phandle' in props and len(props['phandle']) >= 4:
        phandle_map[u32s(props['phandle'])[0]] = root

def path_of(ph):
    return phandle_map.get(ph, 'UNRESOLVED-phandle-0x%x' % ph)

def short(p):
    return p.replace(DTB, '').strip('/') or '/'

# 1. all rockchip,pins groups containing bank3 pin8
print('=== A. pin groups with bank3 pin8 (gpio3_b0) ===')
hits = []
for path, props in nodes.items():
    raw = props.get('rockchip,pins')
    if not raw:
        continue
    v = u32s(raw)
    for i in range(0, len(v) - 3, 4):
        b, p, m, c = v[i], v[i+1], v[i+2], v[i+3]
        if b == 3 and p == 8:
            gph = u32s(props['phandle'])[0] if 'phandle' in props else 0
            hits.append((path, gph, m, c))
for path, gph, m, c in hits:
    print('  group %s (phandle 0x%x) mux=%d cfg=0x%x -> %s' % (short(path), gph, m, c, short(path_of(c))))

# 2. who references those group phandles
print('=== B. devices referencing those groups (pinctrl-0) ===')
gph_set = set(g for _, g, _, _ in hits)
for path, props in nodes.items():
    raw = props.get('pinctrl-0')
    if not raw:
        continue
    refs = u32s(raw)
    for ph in refs:
        if ph in gph_set:
            compat = props.get('compatible', b'?').decode(errors='replace').strip('\x00')
            status = props.get('status', b'okay').decode(errors='replace').strip('\x00')
            print('  %s [%s] status=%s pinctrl-0=%s' % (short(path), compat, status, [hex(x) for x in refs]))

# 3. pcfg nodes for those cfg phandles
print('=== C. pcfg node contents ===')
seen = set()
for path, gph, m, c in hits:
    if c in seen:
        continue
    seen.add(c)
    cp = path_of(c)
    props = nodes.get(cp, {})
    keys = sorted(k for k in props if not k.startswith('linux'))
    print('  cfg 0x%x at %s: %s' % (c, short(cp), {k: u32s(props[k]) for k in keys if k not in ('phandle', 'linux,phandle')}))

# 4. gpio3 bank node full
print('=== D. gpio@ff240000 node ===')
for path, props in nodes.items():
    if path.endswith('/gpio@ff240000'):
        for k in sorted(props):
            v = props[k]
            if k in ('compatible', 'status', 'gpio-controller', '#gpio-cells', '#interrupt-cells'):
                print('  %s = %s' % (k, v.decode(errors='replace').strip('\x00')))
            elif len(v) <= 16:
                print('  %s = %s' % (k, [hex(x) for x in u32s(v)]))
        break

# 5. pwrseq node
print('=== E. pwrseq node ===')
for path, props in nodes.items():
    if 'mmc-pwrseq-simple' in props.get('compatible', b''):
        for k in sorted(props):
            v = props[k]
            if k in ('compatible',):
                print('  %s = %s' % (k, v.decode(errors='replace').strip('\x00')))
            elif len(v) <= 16:
                print('  %s = %s' % (k, [hex(x) for x in u32s(v)]))
        print('  path=%s' % short(path))

# 6. GRF io_vsel
print('=== F. GRF registers 0x100-0x108 ===')
try:
    with open(GRF) as f:
        for line in f:
            off = int(line.split(':')[0], 16)
            if 0x100 <= off <= 0x108:
                print('  ' + line.strip())
except Exception as e:
    print('  ERR', e)

# 7. pinconf for pins 96-104
print('=== G. pinconf pins 96-105 ===')
try:
    with open(PC) as f:
        for line in f:
            m = re.match(r'pin (9[6-9]|10[0-5]) ', line)
            if m:
                print('  ' + line.strip())
except Exception as e:
    print('  ERR', e)
