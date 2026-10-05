import sys
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
import re
from androguard.core.dex import DEX
path, pat = sys.argv[1], re.compile(sys.argv[2])
d = DEX(open(path, 'rb').read())
for c in d.get_classes():
    if not pat.search(c.get_name()): continue
    print('#'*90)
    print('CLASS', c.get_name(), ' super=', c.get_superclassname())
    for f in c.get_fields():
        iv = f.get_init_value()
        try: v = iv.get_value()
        except Exception: v = None
        print('  FIELD %-30s %-24s = %r' % (f.get_name(), f.get_descriptor(), v))
    for m in c.get_methods():
        code = m.get_code()
        print('-'*80)
        print('  METHOD %s%s' % (m.get_name(), m.get_descriptor()))
        if code is None: continue
        for i in code.get_bc().get_instructions():
            print('    %-16s %s' % (i.get_name(), i.get_output()))
