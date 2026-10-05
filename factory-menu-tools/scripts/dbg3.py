import sys
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
from androguard.core.dex import DEX
d = DEX(open(r'C:\firmware_temp\factory_menu_analysis_20260926\dex\classes2.dex','rb').read())
shown=0
for c in d.get_classes():
    if c.get_name() != 'Lmediatek/tvsetting/factory/ui/designmenu/AUDIO_nonStan;':
        continue
    for m in c.get_methods():
        if m.get_name() != 'onKeyDown': continue
        ins = list(m.get_code().get_bc().get_instructions())
        for i in ins:
            op = i.get_op_value()
            if 0x52 <= op <= 0x6d:
                print('%02x  %-14s out=%r  operands=%r' % (op, i.get_name(), i.get_output(), i.get_operands()))
                shown += 1
                if shown > 12: raise SystemExit
