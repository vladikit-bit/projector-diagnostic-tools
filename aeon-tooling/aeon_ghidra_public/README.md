# AEON processor module for Ghidra (patched)

A minimally-patched copy of the open-source **ghidra-aeon** Ghidra processor module,
prepared so that it builds and loads cleanly on **Ghidra 12.1.2**.

Target hardware: MStar / MedTek **AEON** DSP (e.g. MT5889 / "R2" audio DSP).

---

## What this is

This repository contains only the **AEON processor module source files** needed to
reproduce the fix. It is *not* a firmware project and contains **no firmware,
binaries, logs or device data of any kind**.

The only functional change versus upstream is **two lines** in
`data/languages/aeon.slaspec` (see [PATCH_NOTES.md](PATCH_NOTES.md)).

---

## The problem

Ghidra 12.x recompiles a processor module's `.sla` from source on load, and is
stricter than the Ghidra version this module was written for. On a clean
Ghidra 12.1.2 the unmodified module fails with a SLEIGH compile error caused by two
reversed bit-field ranges:

```
i16_uimm4_2 = (4, 2)      # start bit > end bit  -> invalid
i24_uimm4_2 = (4, 2)      # start bit > end bit  -> invalid
```

SLEIGH bit ranges must be written `(endbit, startbit)` — i.e. the *lower* index
first. Both fields had the pair reversed.

## The fix

```diff
--- a/data/languages/aeon.slaspec
+++ b/data/languages/aeon.slaspec
@@ -42,7 +42,7 @@
-	i16_uimm4_2 = (4, 2)
+	i16_uimm4_2 = (2, 4)
@@ -92,7 +92,7 @@
-	i24_uimm4_2 = (4, 2)
+	i24_uimm4_2 = (2, 4)
```

Both fields are **unused** — no SLEIGH constructor references either
`i16_uimm4_2` or `i24_uimm4_2`. Therefore **no instruction decoding semantics are
changed**; the patch only makes the specification compile. See
[PATCH_NOTES.md](PATCH_NOTES.md) for the full reasoning and verification.

---

## Repository contents

```
aeon/
├── Module.manifest          (empty, as upstream)
├── LICENSE                  (Apache 2.0, verbatim from upstream)
├── sprs.py                  (SPR table generator, unchanged)
└── data/
    ├── build.xml            (SLEIGH build file, unchanged)
    ├── sleighArgs.txt       (unchanged)
    ├── languages/
    │   ├── aeon.cspec       (unchanged)
    │   ├── aeon.ldefs       (unchanged)
    │   ├── aeon.pspec       (unchanged)
    │   ├── aeon.slaspec     <-- PATCHED (2 lines)
    │   ├── aeon_ORBIS32.sinc     (unchanged)
    │   ├── aeon_ORBIS32_old.sinc (unchanged)
    │   └── aeon_SPRs.sinc        (unchanged)
    └── patterns/
        ├── aeon_BE_patterns.xml  (unchanged)
        └── patternconstraints.xml (unchanged)
```

### Deliberately NOT included: `aeon.sla`

The upstream archive ships a pre-built `data/languages/aeon.sla`. **It is excluded
here on purpose.** `.sla` is a *generated* artifact: Ghidra compiles it from
`aeon.slaspec` via the SLEIGH compiler (`data/build.xml`), and a stale `.sla`
compiled for an older Ghidra version will be rejected or mis-handled by 12.1.2.
Let your Ghidra build it. See [COMPATIBILITY.md](COMPATIBILITY.md).

---

## Install

1. Start from a **clean, unmodified Ghidra 12.1.2** install.
2. Copy the `aeon/` directory into Ghidra's processor directory:

   ```
   <GHIDRA_INSTALL_DIR>/Ghidra/Processors/aeon
   ```

   On Windows this is typically `C:\ghidra_12.1.2_PUBLIC\Ghidra\Processors\aeon`.
3. If a `Ghidra/Processors/aeon` directory already exists, remove or rename it
   first so no stale files (especially an old `aeon.sla`) are left behind.
4. Launch Ghidra (GUI or headless). Ghidra compiles `aeon.slaspec` → `aeon.sla`
   automatically on first language load.

---

## Verify the install

Language ID: **`aeon:LE:32:default`**

### GUI

`File → New Project` → `File → Import File` → choose a raw binary →
set Language to **AEON** (`aeon:LE:32:default`). If the language appears and the
import succeeds, the module works.

### Headless

```bat
analyzeHeadless.bat <projdir> <projname> ^
  -import <file.bin> ^
  -loader BinaryLoader -loader-baseAddr 0 ^
  -processor aeon:LE:32:default
```

Run from `<GHIDRA_INSTALL_DIR>\support\`. A successful run ends with
`REPORT: Import succeeded` and creates a project.

> **Sandbox / CI note:** `analyzeHeadless.bat` needs `APPDATA` to be set and a
> registered JDK (or `JAVA_HOME`). In a stripped environment the `.bat` chain can
> exit silently. If that happens, invoke Java directly:
>
> ```
> java -Djava.system.class.loader=ghidra.GhidraClassLoader \
>      -Dapplication.settingsdir=<writable dir> \
>      -cp <GHIDRA>/Ghidra/Framework/Utility/lib/Utility.jar \
>      ghidra.Ghidra ghidra.app.util.headless.AnalyzeHeadless <args...>
> ```

---

## Reproducing the verification

The verification recorded in [PATCH_NOTES.md](PATCH_NOTES.md) was:

1. Confirm the diff against upstream is exactly the two lines above
   (`diff -r upstream/ aeon/`).
2. Delete any stale `aeon.sla`, launch Ghidra 12.1.2 headless, import a raw AEON
   binary at base address `0`, processor `aeon:LE:32:default`.
3. Confirm `REPORT: Import succeeded` and that SLEIGH compiled without error.
4. Disassemble; confirm instructions decode across all three widths
   (`bg.*` 4-byte, `bn.*` 3-byte, `bt.*` 2-byte).

---

## Encoding reference (handy when reading disassembly)

Derived from `aeon.slaspec` + `aeon_ORBIS32.sinc`. Token bit 0 = LSB, bytes are
big-endian.

| Width | Opcode field | Registers | Immediate |
|---|---|---|---|
| 32-bit `bg.*` | `(w>>26)&0x3F` | `rD=(w>>21)&0x1F`, `rA=(w>>16)&0x1F` | `w & 0xFFFF` |
| 24-bit `bn.*` | `(w>>18)&0x3F` | `rD=(w>>13)&0x1F`, `rA=(w>>8)&0x1F`, `rB=(w>>3)&0x1F` | `w & 0xFF` |
| 16-bit `bt.*` | `(w>>10)&0x3F` | `rD=(w>>5)&0x1F`, `rA=w&0x1F` | — |

Common 32-bit opcodes: `0x30` movhi/sf\*, `0x31` andi, `0x32` ori, `0x34`/`0x35`
branches, `0x39` jal (bit0=0) / j (bit0=1), `0x3B` sw/lwz/sh, `0x3F` addi.

Width is selected by a "decoder" sub-field, so 4/3/2-byte instructions are freely
interleaved — always disassemble from a known entry point, never on a fixed
4-byte stride.

---

## Upstream

See [UPSTREAM_PROVENANCE.md](UPSTREAM_PROVENANCE.md). All credit for the module
belongs to the original authors; this repository only carries the two-line
compatibility fix.

## License

Apache License 2.0 — inherited unchanged from upstream (`aeon/LICENSE`).
