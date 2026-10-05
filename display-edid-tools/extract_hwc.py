# Ghidra script to extract HWC display config related functions
from ghidra.app.decompiler import DecompileOptions
from ghidra.app.decompiler import DecompInterface
from ghidra.util.task import ConsoleTaskMonitor
from ghidra.program.model.listing import FunctionIterator
import json

program = currentProgram
decompiler = DecompInterface()
decompiler.openProgram(program)

# Search for relevant functions
keywords = [
    "initConfigs", "getDisplayConfigs", "Config", "mConfigs", 
    "HWCDisplayDevice", "getDisplayAttribute", "getActiveConfig",
    "setActiveConfig", "getConfigs", "populateConfig"
]

results = {}
for func in program.getFunctionManager().getFunctions(True):
    name = func.getName()
    for kw in keywords:
        if kw.lower() in name.lower():
            if name not in results:
                results[name] = {"address": str(func.getEntryPoint()), "size": func.getBody().getNumAddresses()}
            
            # Try to decompile
            try:
                res = decompiler.decompileFunction(func, 30, ConsoleTaskMonitor())
                if res.decompileCompleted():
                    results[name]["decompiled"] = res.getDecompiledFunction().getC()
            except:
                results[name]["decompiled"] = "Decompilation failed"
            break

# Also search for strings related to display configs
for string in program.getListing().getDefinedStrings(True):
    s = str(string)
    for kw in ["1920", "1080", "3840", "2160", "50", "60", "24", "30", "720", "config", "mode", "timing"]:
        if kw in s:
            results[f"STRING:{string.getAddress()}"] = s
            break

print(json.dumps(results, indent=2))
