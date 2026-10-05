import sys
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
import re
from androguard.core.dex import DEX
path, pat = sys.argv[1], re.compile(sys.argv[2], re.I)
d = DEX(open(path,'rb').read())
for c in d.get_classes():
    cn = c.get_name()
    for f in c.get_fields():
        if pat.search(f.get_name()):
            iv = f.get_init_value()
            try:
                v = iv.get_value()
            except Exception:
                v = '<?>'
            print('%-70s %-55s %-8s = %r' % (cn, f.get_name(), f.get_descriptor(), v))
