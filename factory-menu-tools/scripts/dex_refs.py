"""Locate classes/methods that declare or reference given strings in a DEX.

Usage:
  python dex_refs.py <file.dex> <regex>          # methods whose const-string matches
  python dex_refs.py <file.dex> --names <regex>  # fields/methods whose NAME matches
"""
import re
import sys

sys.path.insert(0, r'C:\firmware_temp\factory_menu_analysis_20260926\tools')

from androguard.core.dex import DEX  # noqa: E402


def main():
    path = sys.argv[1]
    mode = sys.argv[2] if len(sys.argv) > 2 else 'refs'
    pattern = re.compile(sys.argv[3], re.I)

    with open(path, 'rb') as fh:
        d = DEX(fh.read())

    if mode == '--names':
        for c in d.get_classes():
            cname = c.get_name()
            for f in c.get_fields():
                if pattern.search(f.get_name()):
                    print('FIELD  %s  ->  %s' % (cname, f.get_name()))
            for m in c.get_methods():
                if pattern.search(m.get_name()):
                    print('METHOD %s  ->  %s' % (cname, m.get_name()))
        return

    for c in d.get_classes():
        cname = c.get_name()
        for m in c.get_methods():
            code = m.get_code()
            if code is None:
                continue
            try:
                bc = code.get_bc()
                ins = list(bc.get_instructions())
            except Exception:
                continue
            hit = False
            for i in ins:
                op = i.get_op_value()
                if op in (0x1A, 0x1B):  # const-string, const-string/jumbo
                    s = i.get_output()
                    if pattern.search(s):
                        hit = True
                        print('%s  %s  :  %s' % (cname, m.get_name(), s))
                        break
            del hit


if __name__ == '__main__':
    main()
