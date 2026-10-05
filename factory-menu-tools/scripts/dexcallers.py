import sys
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
import re
from androguard.core.dex import DEX
path, pat = sys.argv[1], re.compile(sys.argv[2])
d = DEX(open(path, 'rb').read())
for c in d.get_classes():
    cn = c.get_name()
    for m in c.get_methods():
        code = m.get_code()
        if code is None: continue
        try: ins = list(code.get_bc().get_instructions())
        except Exception: continue
        for i in ins:
            op = i.get_op_value()
            if 0x6e <= op <= 0x72:
                try: out = i.get_output()
                except Exception: continue
                if pat.search(out):
                    print('%s  ->  %s%s   [calls %s]' % (cn, m.get_name(), m.get_descriptor(), out))
