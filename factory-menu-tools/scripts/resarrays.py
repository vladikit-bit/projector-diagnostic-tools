import sys
sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')
from loguru import logger
logger.remove()
import re
from androguard.core.apk import APK
a = APK(sys.argv[1])
pat = re.compile(sys.argv[2], re.I)
res = a.get_android_resources()
for rid in sys.argv[3:]:
    rid = int(rid, 0)
    try:
        nm = res.get_resource_xml_name(rid)
    except Exception as e:
        nm = '<?>'
    print('=== id 0x%08x (%s) name=%s' % (rid, rid, nm))
    for cfg in res.get_res_configs(rid):
        if nm and not pat.search(str(nm)):
            continue
        print('   cfg:', cfg[0], cfg[1])
        try:
            v = cfg[2]
            print('   value:', repr(v))
        except Exception:
            pass
    try:
        print('   resolved:', res.get_resolved_res_configs(rid))
    except Exception as e:
        print('   (resolve err %s)' % e)
