// Trace DTS SDO Packer data flow
//@category Analysis
import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.*;
import ghidra.program.model.listing.*;
import ghidra.program.model.address.Address;
import ghidra.program.model.symbol.Reference;
import ghidra.program.model.scalar.Scalar;
import ghidra.program.model.pcode.*;
import ghidra.util.task.ConsoleTaskMonitor;

import java.io.FileWriter;
import java.util.*;

public class TraceDTSPath extends GhidraScript {
    static String[] TARGET_FUNCS = {
        "DTSDecSDOPacker_API_Process",
        "DTSDecSDOPacker_API_StartFrame",
        "DTSSPDIFPackFrame",
        "PackSPDIFStream",
        "DTSX_CORE2_API_SDO_Packer",
        "HAL_AUDIO_SPDIF_BypassMode",
        "HAL_AUDIO_SPDIF_AutoMode",
        "HAL_AUDIO_SPDIF_SetMode",
        "HAL_AUDIO_SPDIF_Tx_SetNonPCM",
        "MApi_AUDIO_SPDIF_SetMode",
        "MTGADEC_MTAUD_SetSPDIFEnable",
        "_MiIecConfig",
        "MTGADEC_MTAUD_SetIecConfig"
    };
    
    @Override
    public void run() throws Exception {
        StringBuilder out = new StringBuilder();
        out.append("=== DTS SDO Packer Data Flow Analysis ===\n\n");
        
        FunctionManager fm = currentProgram.getFunctionManager();
        DecompInterface di = new DecompInterface();
        di.openProgram(currentProgram);
        
        // Find target functions by name (including partial matches)
        for (String target : TARGET_FUNCS) {
            FunctionIterator it = currentProgram.getFunctionManager().getFunctions(true);
            while (it.hasNext()) {
                Function fn = it.next();
                String name = fn.getName();
                if (name.contains(target.replace("_API_", "").replace("_", "")) || 
                    name.contains(target) || target.contains(name)) {
                    analyzeFunction(fn, di, out, 0);
                }
            }
        }
        
        // Also search by string references
        out.append("\n=== STRING REFERENCES ===\n");
        String[] strings = {"DTS_SDO_SPDIF_OUT", "DTS_SDO_HDMI_OUT", "DTS_SDO_HDMI_IN", 
            "SPDIF", "SpdifPacker", "SPDIFPacker", "DTSSPDIFPackFrame", "PackSPDIFStream"};
        for (String s : strings) {
            findStringReferences(s);
        }
        
        FileWriter fw = new FileWriter("C:\\firmware_temp\\spdif_audio_investigation\\ghidra_dts_flow.txt");
        fw.write(out.toString());
        fw.close();
        println("Analysis complete. Output written to ghidra_dts_flow.txt");
    }
    
    void findStringReferences(String searchStr) {
        try {
            Address[] addrs = currentProgram.getMemory().getBytes(searchStr.getBytes());
            if (addrs.length == 0) {
                // Try in string tables
                for (int i = 0; i < 10; i++) {
                    try {
                        String str = currentProgram.getMemory().getString(new Address(0));
                        if (str.contains(searchStr)) {
                            out.append("Found string '").append(searchStr).append("' in memory\n");
                        }
                    }
                }
            }
        } catch (Exception e) {
            out.append("Error searching ").append(searchStr).append(": ").append(e.getMessage()).append("\n");
        }
    }
    
    void analyzeFunction(Function fn, DecompInterface di, StringBuilder out, int depth) {
        String indent = "  ".repeat(depth);
        out.append(indent).append("FUNCTION: ").append(fn.getName()).append(" @ ").append(fn.getEntryPoint()).append("\n");
        
        // Get references to this function
        ReferenceIterator refIt = getReferencesTo(fn.getEntryPoint());
        while (refIt.hasNext()) {
            Reference ref = refIt.next();
            Address fromAddr = ref.getFromAddress();
            Function caller = getFunctionContaining(fromAddr);
            String callerName = caller != null ? caller.getName() : "UNKNOWN@" + fromAddr;
            out.append(indent).append("  CALLED FROM: ").append(callerName).append(" @ ").append(fromAddr).append(" (").append(ref.getReferenceType()).append(")\n");
            
            if (depth < 2) {
                Function callerFn = getFunctionContaining(fromAddr);
                if (callerFn != null && !callerFn.getName().equals(fn.getName())) {
                    analyzeFunction(callerFn, new DecompInterface(), out, depth + 1);
                }
            }
        }
        
        // Decompile and look for buffer operations
        DecompileResults res = new DecompInterface().openProgram(currentProgram).decompileFunction(fn, 120, monitor);
        if (res.decompileCompleted()) {
            String code = res.getDecompiledFunction().getC();
            if (code.contains("SPDIF") || code.contains("spdif") || code.contains("SPDIF") || 
                code.contains("spdifFrmBuf") || code.contains("spdifFrmBuf") || code.contains("SPDIF") ||
                code.contains("SPDIF") || code.contains("spdifFrmBuf") || code.contains("SPDIF")) {
                out.append(indent).append("  [CONTAINS SPDIF REFS]\n");
            }
            if (code.contains("spdifFrmBuf") || code.contains("ppSPDIFFrmBuf") || code.contains("SPDIF_FrmBuf")) {
                out.append(indent).append("  [CONTAINS SPDIF FRM BUF REF]\n");
            }
            if (code.contains("output_buf") || code.contains("ppSPDIFFrmBuf")) {
                out.append(indent).append("  [OUTPUT BUFFER REF]\n");
            }
        }
    }
}