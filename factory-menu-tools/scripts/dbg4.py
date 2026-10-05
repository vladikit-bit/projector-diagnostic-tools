import sys
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
from androguard.core.dex import DEX
d = DEX(open(r'C:\firmware_temp\factory_menu_analysis_20260926\osd\NtechSettings\classes.dex','rb').read())
n=0
for c in d.get_classes():
    if 'bkdisplay/settings/model/action' in c.get_name():
        n+=1
        ms = c.get_methods()
        print(c.get_name(), 'methods=', len(ms))
        if n>6: break
