// Find all callers of a named function and decompile them
//@category Analysis
import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.*;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.*;
import ghidra.program.model.symbol.RefType;

import java.io.FileWriter;
import java.util.*;

public class FindCallers extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] args = getScriptArgs();
        String outPath = args[0];
        String targetName = args[1];

        StringBuilder out = new StringBuilder();
        FunctionManager fm = currentProgram.getFunctionManager();
        DecompInterface di = new DecompInterface();
        di.openProgram(currentProgram);

        // find target function(s) by name
        List<Function> targets = new ArrayList<>();
        FunctionIterator it = fm.getFunctions(true);
        while (it.hasNext()) {
            Function fn = it.next();
            if (fn.getName().contains(targetName)) targets.add(fn);
        }
        out.append("targets matched: " + targets.size() + "\n");
        for (Function t : targets) out.append("  " + t.getName() + " @ " + t.getEntryPoint() + "\n");

        Set<String> seen = new HashSet<>();
        for (Function t : targets) {
            Address te = t.getEntryPoint();
            ReferenceIterator rit = currentProgram.getReferenceManager().getReferenceIterator(te);
            // also use getReferencesTo
            for (Reference r : getReferencesTo(te)) {
                Address from = r.getFromAddress();
                Function fn = fm.getFunctionContaining(from);
                String key = fn != null ? fn.getName() + "@" + fn.getEntryPoint() : from.toString();
                out.append("ref " + r.getReferenceType() + " from " + from + " in " + key + "\n");
                if (fn != null && seen.add(key)) {
                    DecompileResults res = di.decompileFunction(fn, 120, monitor);
                    if (res.decompileCompleted()) {
                        String code = res.getDecompiledFunction().getC();
                        out.append("--- DECOMPILE " + fn.getName() + " @ " + fn.getEntryPoint() + " ---\n")
                           .append(code).append("\n");
                    }
                }
            }
        }
        FileWriter fw = new FileWriter(outPath);
        fw.write(out.toString());
        fw.close();
        println("DONE " + outPath);
    }
}
