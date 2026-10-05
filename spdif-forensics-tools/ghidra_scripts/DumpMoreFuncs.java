// Decompile additional functions by name substring
//@category Analysis
import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.*;
import ghidra.program.model.listing.*;

import java.io.FileWriter;
import java.util.*;

public class DumpMoreFuncs extends GhidraScript {
    static String[] WANT = {
        "mi_common_raw_write",
        "utils_common_out_write",
        "out_write",
        "Parser_Write",
        "Parser_Read",
        "mi_decoder_write",
        "mi_decoder_read",
        "ac3_parser_write",
        "ac3_parser_read",
        "dts_parser_write",
        "dts_parser_read",
        "mi_decoder_process",
        "mi_common_raw_read"
    };

    @Override
    public void run() throws Exception {
        StringBuilder out = new StringBuilder();
        DecompInterface di = new DecompInterface();
        di.openProgram(currentProgram);
        FunctionIterator it = currentProgram.getFunctionManager().getFunctions(true);
        while (it.hasNext()) {
            Function fn = it.next();
            String n = fn.getName();
            boolean match = false;
            for (String w : WANT) if (n.contains(w)) { match = true; break; }
            if (!match) continue;
            DecompileResults res = di.decompileFunction(fn, 120, monitor);
            out.append("\n===== ").append(n).append(" @ ").append(fn.getEntryPoint()).append(" =====\n");
            if (res.decompileCompleted()) {
                out.append(res.getDecompiledFunction().getC());
            } else {
                out.append("DECOMPILE FAILED: ").append(res.getErrorMessage());
            }
        }
        FileWriter fw = new FileWriter("C:\\firmware_temp\\spdif_audio_investigation\\ghidra_hal_funcs2.c");
        fw.write(out.toString());
        fw.close();
        println("DONE wrote ghidra_hal_funcs2.c");
    }
}
