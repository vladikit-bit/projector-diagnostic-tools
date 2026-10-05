# Compatibility

## Tested matrix

| Ghidra version | Status | Notes |
|---|---|---|
| **12.1.2** | **Works** | Verified: SLEIGH compiles, `aeon:LE:32:default` loads, headless import succeeds, disassembly is correct across all three instruction widths. |
| 12.0.x | Expected to work | Same stricter SLEIGH compiler; the two-line fix addresses the same class of error. Not explicitly tested. |
| 11.x and earlier | Not tested | These did *not* recompile `.sla` as aggressively, which is why upstream worked there. The fix is harmless on them (the fields are unused), but it is also unnecessary. |

## Language IDs

Defined in `data/languages/aeon.ldefs`. The one used for verification:

```
aeon:LE:32:default
```

Endianness is big-endian (`define endian=big` in `aeon.slaspec`); the `LE` in the
language ID refers to Ghidra's compiler-spec naming, not to data endianness.

## About the missing `aeon.sla`

Upstream ships `data/languages/aeon.sla` (a pre-compiled SLEIGH binary, ~811 KB in
the upstream archive). **This repository intentionally omits it.**

Reasons:

1. **It is a generated artifact.** It is produced by the SLEIGH compiler from
   `aeon.slaspec` + the `.sinc` includes, driven by `data/build.xml`. Committing
   generated binaries is avoidable churn.
2. **A stale `.sla` is actively harmful on 12.x.** Ghidra 12 recompiles on load; if
   a `.sla` compiled against an older Ghidra/ SLEIGH version is present, it can be
   rejected outright or silently shadow the source. Deleting it and letting Ghidra
   rebuild is the reliable path.

### Rebuilding it

You normally do nothing — Ghidra compiles it automatically the first time the
language is used and caches it next to the sources.

To build explicitly (Ghidra's `sleigh` utility, or via Gradle in a Ghidra source
tree):

```
sleigh -a data/languages data/sleighArgs.txt
```

The resulting `data/languages/aeon.sla` is **not** meant to be committed.

## Instruction widths and the "don't sweep on a stride" rule

AEON interleaves three instruction widths in the same code stream. Width is chosen
by a *decoder* sub-field, and each width reads that field at a **different bit
offset**, which is precisely what keeps the encodings unambiguous:

| Width | Prefix | Opcode bits | Decoder field | Decoder values |
|---|---|---|---|---|
| 4 bytes | `bg.*` | `(w>>26)&0x3F` | `(w>>29)&0x7` | `5, 6, 7` |
| 3 bytes | `bn.*` | `(w>>18)&0x3F` | `(w>>21)&0x7` | `0, 1, 2, 3` |
| 2 bytes | `bt.*` | `(w>>10)&0x3F` | `(w>>13)&0x7` | `4` |

Practical consequences:

* **Never** disassemble with a fixed stride (neither 4 nor 2 nor 3). Any
  fixed-stride linear sweep will, sooner or later, start mid-instruction and emit
  garbage until it happens to re-synchronise.
* Start from known entry points (reset vector, interrupt table, call targets) and
  follow flow, i.e. recursive descent.
* To *discover* boundaries in an unexplored region, a step-1 pass that attempts a
  decode at **every** byte is effective: true instruction starts decode, misaligned
  offsets do not. Then keep only the maximal *contiguous* chains
  (`addr + length == next_addr`).
* When scanning a region for an instruction with a particular immediate, search by
  **encoding** (construct the instruction word from the opcode/register/immediate
  fields) rather than by raw byte pattern. Raw byte searches for 16-bit constants
  produce heavy false-positive rates because opcode+operand bytes constantly
  coincide with arbitrary constants.

## Known limitations carried over from upstream

* `bg.jal` flow/target computation is unreliable — verify independently.
* Many `bn.op*` / `bg.opcode_*` constructors are placeholders; some are annotated
  in-source as `hangs on hw` or `invalid?`.
* `bn.subb` / `bn.addc` are marked `TODO` (no carry/borrow semantics).
* `aeon_ORBIS32_old.sinc` is retained from upstream but is not included by
  `aeon.slaspec`.
