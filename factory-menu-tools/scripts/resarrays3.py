import sys
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
from androguard.core.apk import APK
a = APK(sys.argv[1])
res = a.get_android_resources()
for arg in sys.argv[2:]:
    rid = int(arg, 0)
    nm = res.get_resource_xml_name(rid)
    print('=== 0x%08x  %s' % (rid, nm))
    for cfg, entry, *_ in res.get_res_configs(rid):
        h = entry.get_value()
        print('  cfg=%r  type=%s' % (cfg.getLocale() if hasattr(cfg,'getLocale') else '?', type(h)))
        if hasattr(h, 'get_array_values'):
            for i, it in enumerate(h.get_array_values()):
                v = it.get_value() if hasattr(it, 'get_value') else it
                if hasattr(v, 'get_value'):
                    v = v.get_value()
                print('     [%d] %r' % (i, v))
            break
        else:
            print('     value=%r' % (h,))
            break
