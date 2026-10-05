// SND33_RealCode: dump ONLY analysed instructions, from code blocks.
//
// Why: SND32/DEC32_DumpAll sweep every offset and emit whatever the sleigh decoder
// accepts, so data bytes that happen to be legal encodings are rendered as
// instructions.  Re-running with analysis did NOT change the count (293 721 both
// times) because the sweep is unconditional.  Enumerating code blocks is the fix.
//
// Output is identical in shape to dec32_clean.txt so the downstream Python works:
//   <addr> <length> <mnemonic + operands> | <bytes, file order>
//
//@category AEON

import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.block.CodeBlock;
import ghidra.program.model.block.CodeBlockIterator;
import ghidra.program.model.listing.Instruction;
import ghidra.program.model.listing.InstructionIterator;
import ghidra.program.model.listing.Listing;

import java.util.Map;
import java.util.TreeMap;

public class SND33_RealCode extends GhidraScript {

    private Listing listing;

    private String bytesHex(Address a, int n) throws Exception {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            sb.append(String.format("%02x", currentProgram.getMemory().getByte(a.add(i)) & 0xFF));
        }
        return sb.toString();
    }

    @Override
    protected void run() throws Exception {
        listing = currentProgram.getListing();
        println("### SND33_RealCode " + currentProgram.getName()
                + " max=0x" + Long.toHexString(currentProgram.getMaxAddress().getOffset()));

        TreeMap<Long, Instruction> map = new TreeMap<Long, Instruction>();
        CodeBlockIterator cbIt = listing.getCodeBlocks(true);
        int blocks = 0;
        while (cbIt.hasNext()) {
            CodeBlock cb = cbIt.next();
            if (cb.getStart() == null) {
                continue;
            }
            blocks++;
            InstructionIterator ii = listing.getInstructions(cb, true);
            while (ii.hasNext()) {
                Instruction ins = ii.next();
                map.put(ins.getAddress().getOffset(), ins);
            }
        }

        long count = 0;
        for (Map.Entry<Long, Instruction> e : map.entrySet()) {
            Instruction ins = e.getValue();
            int len = ins.getLength();
            if (len <= 0) {
                continue;
            }
            println(String.format("%06x %d %s | %s",
                    e.getKey().longValue(), len, ins.toString(), bytesHex(ins.getAddress(), len)));
            count++;
        }
        println("### code blocks: " + blocks);
        println("### total real instructions: " + count);
        println("### END SND33");
    }
}