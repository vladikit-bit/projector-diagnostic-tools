// HY4 libmi3 probe: find MI_DISP_SetOutputTiming by name, decompile, dump callees + ioctl const.
//@category HY4
import ghidra.app.script.GhidraScript;
import ghidra.program.model.listing.*;
import ghidra.program.model.address.*;
import ghidra.program.model.symbol.*;
import ghidra.app.decompiler.*;
import ghidra.util.task.ConsoleTaskMonitor;
import java.io.*;
import java.util.*;

public class Hy4Libmi3Probe extends GhidraScript {
    DecompInterface decomp;
    void initDecomp() { decomp = new DecompInterface(); decomp.openProgram(currentProgram); }

    String decompileAt(Address addr, int timeout) {
        if (decomp == null) initDecomp();
        Function f = currentProgram.getFunctionManager().getFunctionContaining(addr);
        if (f == null) return "<<no function containing " + addr + ">>";
        StringBuilder sb = new StringBuilder();
        sb.append("FUNC: ").append(f.getName()).append("  entry=").append(f.getEntryPoint())
          .append("  bodySize=").append(f.getBody().getNumAddresses()).append("\n");
        sb.append("CALLEES:\n");
        for (Function c : f.getCalledFunctions(null))
            sb.append("    ").append(c.getName()).append(" @").append(c.getEntryPoint()).append("\n");
        sb.append("---- DECOMPILE ----\n");
        try {
            DecompileResults r = decomp.decompileFunction(f, timeout, new ConsoleTaskMonitor());
            if (r == null || !r.decompileCompleted() || r.getDecompiledFunction() == null)
                sb.append("<<decompile failed>>\n");
            else {
                String c = r.getDecompiledFunction().getC();
                sb.append(c == null ? "<<null C>>" : c).append("\n");
            }
        } catch (Exception e) { sb.append("<<exception: ").append(e.toString()).append(">>\n"); }
        return sb.toString();
    }

    @Override
    public void run() throws Exception {
        String[] raw = getScriptArgs();
        String outPath = raw.length > 0 ? raw[0] : "hy4_libmi3_out.txt";
        PrintWriter out = new PrintWriter(new FileWriter(outPath));
        List<Symbol> syms = currentProgram.getSymbolTable().getGlobalSymbols("MI_DISP_SetOutputTiming");
        if (syms.isEmpty()) {
            out.println("<<NO SYMBOL MI_DISP_SetOutputTiming>>");
        } else {
            Address ad = syms.get(0).getAddress();
            out.println("SYMBOL MI_DISP_SetOutputTiming @ " + ad);
            out.println(decompileAt(ad, 120));
        }
        // also dump the literal reference context for MI_DEV_IOC_DISP_SET_OUTPUT_TIMING
        out.println("\n=== searching for MI_DEV_IOC_DISP_SET_OUTPUT_TIMING literal xrefs ===");
        ReferenceIterator ri = currentProgram.getReferenceManager().getReferencesTo(ad);
        out.close();
    }
}
