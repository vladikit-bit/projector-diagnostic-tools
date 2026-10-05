// Decompile named functions by demangled-name substring
//@category Analysis
import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.*;
import ghidra.program.model.listing.*;

import java.io.FileWriter;
import java.util.*;

public class DumpFuncs extends GhidraScript {
    static String[] WANT = {
        "utils_common_out_get",
        "utils_common_out_set",
        "utils_get_device_name",
        "utils_isParserSupported",
        "utils_isPassthroughSupported",
        "utils_common_out_open",
        "utils_isOffloadPlayback",
        "adev_open_output_stream",
        "mi_common_raw_get",
        "mi_common_pcm_get",
        "out_open"
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
        FileWriter fw = new FileWriter("C:\\firmware_temp\\spdif_audio_investigation\\ghidra_hal_funcs.c");
        fw.write(out.toString());
        fw.close();
        println("DONE wrote ghidra_hal_funcs.c");
    }
}
