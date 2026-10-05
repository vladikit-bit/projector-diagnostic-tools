
# Simple MBOOT analysis script
from ghidra.app.decompiler import DecompInterface
from ghidra.util.task import ConsoleTaskMonitor

program = currentProgram
fm = program.getFunctionManager()
listing = program.getListing()

print("=== FUNCTION COUNT: %d ===" % fm.getFunctionCount())

# Find strings
target_strings = [
    "do_file_part_load_with_segment_aes_decrypted",
    "LoadCustomerKeyBank",
    "do_usb_super_upgrade_to_emmc",
    "_MDrv_DSCMB2_FltDscmb",
    "_MDrv_DSCMB2_FltKeySet",
    "_MDrv_DSCMB2_FltIVSet",
    "aes_decrypt",
    "do_rsa",
]

print("=== SEARCHING FOR TARGET STRINGS ===")
for d in listing.getDefinedData(True):
    val = d.getValue()
    if val is not None:
        s = str(val)
        for target in target_strings:
            if target in s:
                print("FOUND: %s at %s" % (target, d.getAddress()))

# Find references  
ref_mgr = program.getReferenceManager()
for d in listing.getDefinedData(True):
    val = d.getValue()
    if val is not None:
        s = str(val)
        for target in target_strings:
            if target in s:
                addr = d.getAddress()
                refs = ref_mgr.getReferencesTo(addr)
                for ref in refs:
                    from_addr = ref.getFromAddress()
                    func = fm.getFunctionContaining(from_addr)
                    if func:
                        print("REF: %s -> %s @ %s (function: %s)" % (
                            func.getName(), target, from_addr, func.getEntryPoint()))
