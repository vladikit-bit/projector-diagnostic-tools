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
    cfgs = res.get_res_configs(rid)
    entry = cfgs[0][1]
    try:
        items = entry.get_array_values()
    except AttributeError:
        try:
            items = entry.get_value()
        except Exception as e:
            print('   err', e); continue
    if not isinstance(items, (list, tuple)):
        print('   raw:', repr(items)[:300]); continue
    for i, it in enumerate(items):
        try:
            v = it.get_value() if hasattr(it, 'get_value') else it
        except Exception:
            v = it
        if hasattr(v, 'get_value'):
            v = v.get_value()
        print('   [%d] = %r' % (i, v))
