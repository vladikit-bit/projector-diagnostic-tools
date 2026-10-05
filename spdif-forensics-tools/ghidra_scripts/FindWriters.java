// Find writes to a given data address across all functions (search for literal pool refs)
//@category Analysis
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.*;
import ghidra.program.model.symbol.Reference;

import java.io.FileWriter;

public class FindWriters extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] args = getScriptArgs();
        String targetHex = args.length > 0 ? args[0] : "0002c468";
        Address target = currentProgram.getAddressFactory().getAddress(targetHex);
        StringBuilder out = new StringBuilder();
        out.append("Target: ").append(target).append("\n");
        Reference[] refs = getReferencesTo(target);
        out.append("total refs: ").append(refs.length).append("\n");
        FunctionManager fm = currentProgram.getFunctionManager();
        for (Reference r : refs) {
            Address from = r.getFromAddress();
            Function fn = fm.getFunctionContaining(from);
            out.append("ref ").append(r.getReferenceType()).append(" at ").append(from)
               .append(" in ").append(fn != null ? fn.getName() + "@" + fn.getEntryPoint() : "?")
               .append("\n");
        }
        FileWriter fw = new FileWriter("C:\\firmware_temp\\spdif_audio_investigation\\find_writers_out.txt");
        fw.write(out.toString());
        fw.close();
        println("DONE");
    }
}
