import sys, os
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
from androguard.core.dex import DEX
pat = sys.argv[-1]
for p in sys.argv[1:-1]:
    d = DEX(open(p, 'rb').read())
    for c in d.get_classes():
        for m in c.get_methods():
            code = m.get_code()
            if code is None: continue
            strs = [x.get_output() for x in code.get_bc().get_instructions() if x.get_name().startswith('const-string')]
            if any(pat in s for s in strs):
                print('### %s -> %s%s' % (c.get_name(), m.get_name(), m.get_descriptor()))
                for s in strs[:20]:
                    print('     %s' % s)
