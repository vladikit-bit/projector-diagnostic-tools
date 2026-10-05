import sys
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
import re
from androguard.core.dex import DEX
path, classpat, methodpat = sys.argv[1], re.compile(sys.argv[2]), re.compile(sys.argv[3])
d = DEX(open(path, 'rb').read())
for c in d.get_classes():
    if not classpat.search(c.get_name()): continue
    for m in c.get_methods():
        if not methodpat.search(m.get_name()): continue
        code = m.get_code()
        if code is None: continue
        print('='*100)
        print('%s  ->  %s%s' % (c.get_name(), m.get_name(), m.get_descriptor()))
        try:
            ins = list(code.get_bc().get_instructions())
        except Exception as e:
            print('   <bc fail %s>' % e); continue
        for i in ins:
            print('  %04x: %-22s %s' % (i.get_length()*0 + 0, i.get_name(), i.get_output()))
