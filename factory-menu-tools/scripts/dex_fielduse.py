import sys
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
import re
from androguard.core.dex import DEX
path, pat = sys.argv[1], re.compile(sys.argv[2])
d = DEX(open(path,'rb').read())
# map fieldref index -> string
for c in d.get_classes():
    cn = c.get_name()
    for m in c.get_methods():
        code = m.get_code()
        if code is None: continue
        try:
            ins = list(code.get_bc().get_instructions())
        except Exception:
            continue
        hits = []
        for i in ins:
            op = i.get_op_value()
            if 0x52 <= op <= 0x6d:   # sget..iget/iput family
                try:
                    f = i.get_ref_kind()
                except Exception:
                    continue
                try:
                    txt = i.get_output()
                except Exception:
                    continue
                if pat.search(txt):
                    hits.append((op, txt))
        if hits:
            print('%s  ->  %s' % (cn, m.get_name()))
            seen=set()
            for op,txt in hits:
                if txt in seen: continue
                seen.add(txt)
                print('      [%02x] %s' % (op, txt))
