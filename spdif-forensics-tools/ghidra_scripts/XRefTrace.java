//@category Analysis
import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.*;
import ghidra.program.model.listing.*;
import ghidra.program.model.symbol.Reference;
import ghidra.program.model.address.Address;

import java.io.FileWriter;
import java.util.*;

public class XRefTrace extends GhidraScript {
    static String[] TARGETS = {
        "DTSDecSDOPacker_API_StartFrame",
        "DTSDecSDOPacker_API_Process",
        "DTSDecSDOPacker_API_GetFrameSize",
        "HAL_AUDIO_SPDIF_SetOutputType",
        "HAL_AUDIO_SPDIF_Tx_SetNonPCM",
        "HAL_AUDIO_SPDIF_SetMode",
        "HAL_AUDIO_SPDIF_ApplySetting",
        "MI_AUDIO_Write",
        "mi_common_raw_write",
        "utils_common_out_write",
        "out_write",
        "Parser_Write",
        "Parser_Read",
        "dts_parser_write",
        "dts_parser_read",
        "ac3_parser_write",
        "ac3_parser_read",
        "mi_decoder_write",
        "mi_decoder_process",
        "mi_decoder_open",
        "mi_common_raw_open"
    };

    @Override
    public void run() throws Exception {
        StringBuilder out = new StringBuilder();
        FunctionManager fm = currentProgram.getFunctionManager();
        DecompInterface di = new DecompInterface();
        di.openProgram(currentProgram);
        
        out.append("=== SYMBOL LOOKUP ===\n");
        for (String t : TARGETS) {
            Function fn = fm.getFunctionAt(getAddress(t));
            if (fn != null) {
                out.append(String.format("FOUND %s @ %s size=%d\n", t, fn.getEntryPoint(), fn.getBody().getNumAddresses()));
            } else {
                Function[] fns = fm.getFunctions(true);
                boolean found = false;
                for (Function f : fns) {
                    if (f.getName().contains(t) || t.contains(f.getName())) {
                        out.append(String.format("PARTIAL %s -> %s @ %s\n", t, f.getName(), f.getEntryPoint()));
                        found = true;
                    }
                }
                if (!found) {
                    out.append(String.format("NOT_FOUND %s\n", t));
                }
            }
        }
        
        out.append("\n=== XREF ANALYSIS ===\n");
        for (String t : TARGETS) {
            Function fn = fm.getFunctionAt(getAddress(t));
            if (fn == null) {
                Function[] fns = fm.getFunctions(true);
                for (Function f : fns) {
                    if (f.getName().contains(t) || t.contains(f.getName())) {
                        analyzeFunction(f, out);
                    }
                }
            } else {
                analyzeFunction(fn, out);
            }
        }
        
        Function miRawWrite = fm.getFunctionAt(getAddress("mi_common_raw_write"));
        if (miRawWrite == null) {
            Function[] fns = fm.getFunctions(true);
            for (Function f : fns) {
                if (f.getName().contains("mi_common_raw_write")) {
                    miRawWrite = f;
                    break;
                }
            }
        }
        if (miRawWrite != null) {
            out.append("\n=== FORWARD TRACE FROM mi_common_raw_write ===\n");
            traceForward(miRawWrite, out, 0, new HashSet<>());
        }
        
        FileWriter fw = new FileWriter("C:/firmware_temp/spdif_audio_investigation/call_graph_trace.txt");
        fw.write(out.toString());
        fw.close();
        println("DONE wrote call_graph_trace.txt");
    }
    
    void analyzeFunction(Function fn, StringBuilder out) {
        out.append("\n=== ").append(fn.getName()).append(" @ ").append(fn.getEntryPoint()).append(" ===\n");
        Reference[] refs = getReferencesTo(fn.getEntryPoint());
        out.append("Callers (").append(refs.length).append("):\n");
        for (Reference r : refs) {
            Function caller = currentProgram.getFunctionManager().getFunctionContaining(r.getFromAddress());
            out.append("  ").append(r.getReferenceType()).append(" from ")
               .append(caller != null ? caller.getName() + " @ " + caller.getEntryPoint() : r.getFromAddress().toString())
               .append("\n");
        }
    }
    
    void traceForward(Function fn, StringBuilder out, int depth, Set<String> visited) {
        if (depth > 3) return;
        String key = fn.getName() + "@" + fn.getEntryPoint();
        if (visited.contains(key)) return;
        visited.add(key);
        
        out.append("  ".repeat(depth)).append("-> ").append(fn.getName()).append(" @ ").append(fn.getEntryPoint()).append("\n");
        
        DecompInterface di = new DecompInterface();
        di.openProgram(currentProgram);
        DecompileResults res = di.decompileFunction(fn, 60, monitor);
        if (res.decompileCompleted()) {
            String code = res.getDecompiledFunction().getC();
            String[] lines = code.split("\n");
            for (String line : lines) {
                line = line.trim();
                if (line.contains("(") && line.endsWith(";") && !line.startsWith("//")) {
                    int paren = line.indexOf("(");
                    int space = line.lastIndexOf(" ", paren);
                    if (space > 0 && space < paren) {
                        String callee = line.substring(space+1, paren).trim();
                        if (callee.matches("[a-zA-Z_][a-zA-Z0-9_]*")) {
                            Function callee = fm.getFunctionAt(getAddress(callee));
                            if (callee == null) {
                                Function[] fns = fm.getFunctions(true);
                                for (Function f : fns) {
                                    if (f.getName().equals(callee)) {
                                        traceForward(f, out, depth+1, visited);
                                        break;
                                    }
                                }
                            } else {
                                traceForward(callee, out, depth+1, visited);
                            }
                        }
                    }
                }
            }
        }
    }
    
    Address getAddress(String name) {
        try {
            return currentProgram.getAddressFactory().getAddress(name);
        } catch (Exception e) {
            return null;
        }
    }
}
