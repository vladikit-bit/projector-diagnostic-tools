import sys
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
from androguard.core.dex import DEX
d = DEX(open(sys.argv[1],'rb').read())
n=0
for c in d.get_classes():
    if c.get_name() != 'Lmediatek/tvsetting/factory/ui/designmenu/AUDIO_nonStan;': continue
    for m in c.get_methods():
        if m.get_name() != 'updateUi': continue
        code = m.get_code()
        ins = list(code.get_bc().get_instructions())
        for i in ins[:40]:
            print('%02x  %s   ||  %s' % (i.get_op_value(), i.get_name(), i.get_output()))
        n+=1
print('methods matched', n)
