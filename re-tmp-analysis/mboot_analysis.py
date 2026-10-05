# Ghidra Headless Script: Analyze MBOOT upgrade/decryption path
# Run with: analyzeHeadless <project_dir> <project_name> -postScript mboot_analysis.py
#
#@category Analysis
#@runtime PyGhz

import ghidra.program.model.symbol as symbol
import ghidra.program.model.listing as listing
import ghidra.app.decompiler as decompiler
import ghidra.program.model.address as address
from ghidra.script import GhidraScript

class MbootAnalysis(GhidraScript):
    def run(self):
        program = self.getCurrentProgram()
        fm = program.getFunctionManager()
        listing = program.getListing()
        
        # Initialize decompiler
        decomp = decompiler.DecompInterface()
        decomp.openProgram(program)
        
        # Target strings to find
        target_strings = [
            "do_file_part_load_with_segment_aes_decrypted",
            "_load_with_segment_aes_decrypted",
            "LoadCustomerKeyBank",
            "do_usb_super_upgrade_to_emmc",
            "do_usb_partial_upgrade_to_emmc",
            "do_file_segment_rsa_authendication",
            "firmware_image_authendication",
            "check_image_segement_SHA",
            "_MDrv_DSCMB2_FltDscmb",
            "_MDrv_DSCMB2_FltKeySet",
            "_MDrv_DSCMB2_FltIVSet",
            "_MDrv_AESDMA_Init",
            "aes_decrypt",
            "GetfileSizeforAESUsbUpgrade",
            "Secure_CleanFilesize",
            "MsApiChunkHeader_Init",
            "MsApiChunkHeader_GetValue",
            "do_SecureBootCmd",
            "do_rsa",
            "do_sha256",
        ]
        
        # Find defined data containing these strings
        print("=" * 70)
        print("MBOOT ANALYSIS - KEY FUNCTION LOCATOR")
        print("=" * 70)
        
        # Build map of string -> address
        str_addrs = {}
        di = listing.getDefinedData(True)
        for d in di:
            val = d.getValue()
            if val is not None:
                try:
                    s = str(val)
                    for target in target_strings:
                        if target in s:
                            str_addrs[target] = d.getAddress()
                            break
                except:
                    pass
        
        # Also search memory directly
        memory = program.getMemory()
        for target in target_strings:
            if target not in str_addrs:
                # Search for string bytes
                addr = self.findStringInMemory(memory, target)
                if addr:
                    str_addrs[target] = addr
        
        print("\n=== STRING ADDRESSES ===")
        for target, addr in sorted(str_addrs.items(), key=lambda x: x[1].getOffset()):
            print(f"  {addr}: {target}")
        
        # Find references to these strings and identify containing functions
        print("\n=== FUNCTION REFERENCES ===")
        ref_manager = program.getReferenceManager()
        
        results = {}
        for target, str_addr in sorted(str_addrs.items()):
            refs = ref_manager.getReferencesTo(str_addr)
            func_names = []
            for ref in refs:
                from_addr = ref.getFromAddress()
                func = fm.getFunctionContaining(from_addr)
                if func:
                    func_name = func.getName()
                    func_addr = func.getEntryPoint()
                    func_names.append((func_addr.toString(), func_name))
            
            if func_names:
                results[target] = func_names
                print(f"\n  '{target}':")
                for faddr, fname in func_names[:5]:
                    print(f"    → {fname} @ {faddr}")
        
        # Decompile key functions
        print("\n" + "=" * 70)
        print("DECOMPILED FUNCTIONS")
        print("=" * 70)
        
        # Find the main functions we care about
        key_functions = set()
        for target, funcs in results.items():
            for faddr, fname in funcs:
                key_functions.add((faddr, fname))
        
        for faddr, fname in sorted(key_functions):
            try:
                af = address.Address(program.getAddressFactory().getDefaultAddressSpace(), 
                                    int(faddr, 16))
                func = fm.getFunctionAt(af)
                if func:
                    result = decomp.decompileFunction(func, 120, self.monitor)
                    if result.decompileCompleted():
                        code = result.getDecompiledFunction().getC()
                        print(f"\n{'='*60}")
                        print(f"FUNCTION: {fname} @ {faddr}")
                        print(f"{'='*60}")
                        print(code[:5000])  # Limit output
                    else:
                        print(f"\n{fname}: decompilation failed")
            except Exception as e:
                print(f"Error decompiling {fname}: {e}")
        
        decomp.dispose()
    
    def findStringInMemory(self, memory, target):
        """Search memory for ASCII string."""
        target_bytes = target.encode('ascii')
        all_mem = memory.getAllInitializedAddressSet()
        addr_set = all_mem.subtract(
            self.getCurrentProgram().getAddressFactory().getAddressSet(
                self.toAddr(0x300000), self.toAddr(0x400000)))
        
        # Simple search using findBytes
        from ghidra.app.util import SearchInstructionUtil
        # Alternative: iterate through memory blocks
        blocks = memory.getBlocks()
        for block in blocks:
            start = block.getStart()
            size = block.getSize()
            if size > 0x400000:  # Skip huge blocks to avoid timeout
                continue
            
            data = bytearray(size)
            try:
                memory.getBytes(start, data)
                idx = bytes(data).find(target_bytes)
                if idx >= 0:
                    return start.add(idx)
            except:
                pass
        return None

# Execute
analysis = MbootAnalysis()
