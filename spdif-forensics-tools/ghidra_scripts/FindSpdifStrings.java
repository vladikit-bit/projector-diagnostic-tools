// Ghidra post-script: find strings, list references, decompile containing functions
//@category Analysis
import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.*;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.*;
import ghidra.program.model.symbol.Reference;
import ghidra.program.model.scalar.Scalar;

import java.io.FileWriter;
import java.util.*;

public class FindSpdifStrings extends GhidraScript {
    static String[] TARGETS = {
        "unsupport format",
        "open output stream with offload",
        "parser open ok.",
        "There is no offload format information",
        "Unsupported Offload information"
    };

    @Override
    public void run() throws Exception {
        StringBuilder out = new StringBuilder();
        FunctionManager fm = currentProgram.getFunctionManager();
        DecompInterface di = new DecompInterface();
        di.openProgram(currentProgram);
        ghidra.util.task.TaskMonitor m = monitor;

        for (String t : TARGETS) {
            java.util.List<Address> hits = new ArrayList<>();
            Address cur = null;
            for (int i = 0; i < 64; i++) {
                Address hit = findBytes(cur, t);
                if (hit == null) break;
                hits.add(hit);
                cur = hit.add(1);
            }
            if (hits.isEmpty()) { out.append("NOTFOUND ").append(t).append("\n"); continue; }
            for (Address a : hits) {
                out.append("STRING \"").append(t).append("\" @ ").append(a).append("\n");
                Reference[] refs = getReferencesTo(a);
                Set<String> seen = new HashSet<>();
                for (Reference r : refs) {
                    Address from = r.getFromAddress();
                    Function fn = fm.getFunctionContaining(from);
                    String fname = fn != null ? fn.getName() : "?";
                    out.append("  ref from ").append(from).append(" (").append(fname).append(")\n");
                    if (fn != null && seen.add(fn.getName() + fn.getEntryPoint())) {
                        DecompileResults res = di.decompileFunction(fn, 60, m);
                        if (res.decompileCompleted()) {
                            String code = res.getDecompiledFunction().getC();
                            if (code.length() < 25000) {
                                out.append("--- DECOMPILE ").append(fname).append(" @ ")
                                   .append(fn.getEntryPoint()).append(" ---\n").append(code).append("\n");
                            }
                        }
                    }
                }
            }
        }
        FileWriter fw = new FileWriter("C:\\firmware_temp\\spdif_audio_investigation\\ghidra_hal_xrefs.txt");
        fw.write(out.toString());
        fw.close();
        println("DONE wrote ghidra_hal_xrefs.txt");
    }
}
