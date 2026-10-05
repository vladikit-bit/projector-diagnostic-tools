import sys
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
from androguard.core.dex import DEX
d = DEX(open(sys.argv[1],'rb').read())
for c in d.get_classes():
    if c.get_name() != 'Lcom/mediatek/twoworlds/tv/MtkTvAVModeBase;': continue
    for m in c.get_methods():
        print(m.get_name(), m.get_descriptor())
