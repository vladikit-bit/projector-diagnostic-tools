import sys
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
from androguard.misc import AnalyzeDex
path = sys.argv[1]
classpat = sys.argv[2]
methodpat = sys.argv[3] if len(sys.argv) > 3 else None
res = AnalyzeDex(path)
d, dx = res[1], res[2]
import re
cp = re.compile(classpat)
mp = re.compile(methodpat) if methodpat else None
for c in d.get_classes():
    if not cp.search(c.get_name()): continue
    print('='*100)
    print('CLASS', c.get_name())
    for m in c.get_methods():
        if mp and not mp.search(m.get_name()): continue
        code = m.get_code()
        if code is None:
            continue
        try:
            src = dx.get_method_analysis(m).get_source() if hasattr(dx.get_method_analysis(m), 'get_source') else None
            if src is None:
                from androguard.decompiler.decompiler import DecompilerDalvik
                src = str(m.get_source())
        except Exception as e:
            print('-- %s : <decompile failed %s>' % (m.get_name(), e)); continue
        print('-'*90)
        print('METHOD', m.get_name(), m.get_descriptor())
        print(src)
