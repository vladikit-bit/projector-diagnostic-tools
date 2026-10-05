"""Minimal DEX string-table reader (no androguard needed).

Usage:
  python dex_strings.py <file.dex> [keyword_regex]
  python dex_strings.py <file.dex> --list-classes
"""
import re
import struct
import sys


def read_uleb128(buf, off):
    result = 0
    shift = 0
    while True:
        b = buf[off]
        off += 1
        result |= (b & 0x7F) << shift
        if not (b & 0x80):
            return result, off
        shift += 7


def all_strings(path):
    with open(path, 'rb') as fh:
        buf = fh.read()
    if buf[:4] != b'dex\n':
        raise SystemExit('%s: not a dex' % path)
    n_ids, ids_off = struct.unpack_from('<II', buf, 56)
    out = []
    for i in range(n_ids):
        (soff,) = struct.unpack_from('<I', buf, ids_off + 4 * i)
        _n, off = read_uleb128(buf, soff)
        end = buf.index(b'\x00', off)
        out.append(buf[off:end].decode('utf-8', 'replace'))
    return out


def main():
    path = sys.argv[1]
    strs = all_strings(path)
    if len(sys.argv) > 2 and sys.argv[2] == '--list-classes':
        for s in strs:
            if s.startswith('L') and s.endswith(';'):
                print(s)
        return
    pattern = re.compile(sys.argv[2], re.I) if len(sys.argv) > 2 else re.compile('.')
    for s in strs:
        if pattern.search(s):
            print(s)


if __name__ == '__main__':
    main()
