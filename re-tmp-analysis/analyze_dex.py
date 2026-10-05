#!/usr/bin/env python3
"""Analyze classes.dex for OTA-related Java classes and native method calls"""

import sys
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

try:
    from dexparser import Dexparser
except ImportError:
    # Try using the Android dex tools
    import subprocess
    result = subprocess.run(['python3', '-m', 'pip', 'install', 'dexparser'], capture_output=True)
    if result.returncode != 0:
        print("Failed to install dexparser")
        sys.exit(1)
    from dexparser import Dexparser

dex_path = 'C:/tmp/classes.dex'
parser = Dexparser(dex_path)

print("=" * 80)
print("CLASSES.DEX ANALYSIS - OTA/JNI RELATED CLASSES")
print("=" * 80)

# Look for classes with OTA, AES, Patch, etc.
target_classes = []
for cls in parser.classes:
    cls_name = cls.get_name()
    if any(kw in cls_name.lower() for kw in ['ota', 'aes', 'patch', 'encrypt', 'decrypt', 'diff', 'inflate', 'deflate', 'uncompress', 'compress', 'ibio', 'fileio']):
        target_classes.append(cls)

print(f"\nFound {len(target_classes)} target classes:")
for cls in target_classes:
    cls_name = cls.get_name()
    print(f"\n  Class: {cls_name}")
    
    # Print methods
    for method in cls.get_methods():
        method_name = method.get_name()
        method_desc = method.get_descriptor()
        if any(kw in method_name.lower() for kw in ['native', 'decrypt', 'encrypt', 'diff', 'patch', 'inflate', 'deflate', 'uncompress', 'compress', 'ot']):
            print(f"    Method: {method_name}{method_desc}")
            # Check code for invoke-native
            try:
                code = method.get_code()
                if code:
                    for instr in code.get_instructions():
                        if 'invoke' in instr.get_name().lower() and 'native' in instr.get_name().lower():
                            print(f"      -> {instr.get_name()} {instr.get_operands()}")
            except:
                pass

# Also search all classes for native method declarations
print("\n" + "=" * 80)
print("ALL NATIVE METHODS IN DEX")
print("=" * 80)
for cls in parser.classes:
    for method in cls.get_methods():
        if method.get_access_flags() & 0x0100:  # ACC_NATIVE
            print(f"  {cls.get_name()}.{method.get_name()}{method.get_descriptor()}")

# Search for string constants in DEX
print("\n" + "=" * 80)
print("STRING CONSTANTS IN DEX (OTA/CRYPTO RELATED)")
print("=" * 80)
for cls in parser.classes:
    for method in cls.get_methods():
        try:
            code = method.get_code()
            if code:
                for instr in code.get_instructions():
                    operands = str(instr.get_operands())
                    for kw in ['ota', 'OTA', 'AES', 'aes', 'BSDIFF', 'bsdiff', 'bspatch', 'BSPATCH', 
                               'decrypt', 'Decrypt', 'encrypt', 'Encrypt', 'patch', 'Patch',
                               'diff', 'Diff', 'inflate', 'Inflate', 'deflate', 'Deflate',
                               'uncompress', 'Uncompress', 'compress', 'Compress',
                               'IFileIO', 'AESLib', 'PatchLib', 'get_default_key',
                               'nativeDecrypt', 'nativeEncrypt', 'nativeDiff', 'nativePatch',
                               'nativeInflate', 'nativeDeflate', 'nativeUncompress', 'nativeCompress']:
                        if kw in operands:
                            print(f"  {cls.get_name()}.{method.get_name()}: {instr.get_name()} {operands}")
                            break
        except:
            pass

# Search for class references
print("\n" + "=" * 80)
print("CLASS REFERENCES TO com.baidu.otaso.lib.*")
print("=" * 80)
for cls in parser.classes:
    for method in cls.get_methods():
        try:
            code = method.get_code()
            if code:
                for instr in code.get_instructions():
                    operands = str(instr.get_operands())
                    if 'com/baidu/otaso' in operands:
                        print(f"  {cls.get_name()}.{method.get_name()}: {instr.get_name()} {operands}")
        except:
            pass