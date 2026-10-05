import sys, os
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
from androguard.core.dex import DEX
for p in sys.argv[1:]:
    d = DEX(open(p, 'rb').read())
    for c in d.get_classes():
        n = c.get_name()
        if 'PartnerSettingsConfig' not in n: continue
        print('### %s  (%s)' % (n, os.path.basename(p)))
        for m in c.get_methods():
            code = m.get_code()
            if code is None:
                print('   %s%s  (abstract/native)' % (m.get_name(), m.get_descriptor())); continue
            strs = [x.get_output() for x in code.get_bc().get_instructions() if x.get_name().startswith('const-string')]
            print('   %s%s' % (m.get_name(), m.get_descriptor()))
            for s in strs[:12]:
                print('        %s' % s)
