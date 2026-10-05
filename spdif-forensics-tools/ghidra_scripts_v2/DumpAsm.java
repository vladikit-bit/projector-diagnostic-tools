// Dump instruction listing (address, bytes, mnemonic, operands) of a named function
//@category Analysis
import ghidra.app.script.GhidraScript;
import ghidra.program.model.listing.*;
import ghidra.program.model.address.Address;

import java.io.FileWriter;

public class DumpAsm extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] args = getScriptArgs();
        String outPath = args[0];
        String fnName = args[1];
        int maxIns = args.length > 2 ? Integer.parseInt(args[2]) : 400;

        Function fn = null;
        FunctionIterator it = currentProgram.getFunctionManager().getFunctions(true);
        while (it.hasNext()) {
            Function f = it.next();
            if (f.getName().contains(fnName)) { fn = f; break; }
        }
        if (fn == null) { println("FUNCTION NOT FOUND: " + fnName); return; }

        StringBuilder out = new StringBuilder();
        out.append("FUNCTION " + fn.getName() + " @ " + fn.getEntryPoint() + "\n");
        InstructionIterator ii = currentProgram.getListing().getInstructions(fn.getBody(), true);
        int count = 0;
        while (ii.hasNext() && count < maxIns) {
            Instruction ins = ii.next();
            StringBuilder b = new StringBuilder();
            for (byte bt : ins.getBytes()) b.append(String.format("%02x", bt));
            out.append(String.format("%08x  %-12s %-8s %s%n",
                ins.getAddress().getOffset(), b.toString(), ins.getMnemonicString(), ins.toString()));
            count++;
        }
        FileWriter fw = new FileWriter(outPath);
        fw.write(out.toString());
        fw.close();
        println("DONE " + outPath);
    }
}
