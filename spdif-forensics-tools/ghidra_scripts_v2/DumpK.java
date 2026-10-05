// Decompile functions matching name substrings
//@category Analysis
import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.*;
import ghidra.program.model.listing.*;

import java.io.FileWriter;
import java.util.*;

public class DumpK extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] args = getScriptArgs();
        String outPath = args[0];
        Set<String> want = new HashSet<>();
        for (int i = 1; i < args.length; i++) want.add(args[i]);
        StringBuilder out = new StringBuilder();
        DecompInterface di = new DecompInterface();
        di.openProgram(currentProgram);
        FunctionIterator it = currentProgram.getFunctionManager().getFunctions(true);
        while (it.hasNext()) {
            Function fn = it.next();
            String n = fn.getName();
            boolean m = false;
            for (String w : want) if (n.contains(w)) { m = true; break; }
            if (!m) continue;
            DecompileResults res = di.decompileFunction(fn, 180, monitor);
            out.append("\n===== " + n + " @ " + fn.getEntryPoint() + " =====\n");
            out.append(res.decompileCompleted() ? res.getDecompiledFunction().getC() : ("FAILED: " + res.getErrorMessage()));
        }
        FileWriter fw = new FileWriter(outPath);
        fw.write(out.toString());
        fw.close();
        println("DONE " + outPath);
    }
}
