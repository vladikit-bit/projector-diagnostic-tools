# Patch notes — AEON module for Ghidra 12.1.2

## Summary

One file changed, two lines:

```
data/languages/aeon.slaspec
  line  45:  i16_uimm4_2 = (4, 2)   ->   i16_uimm4_2 = (2, 4)
  line  95:  i24_uimm4_2 = (4, 2)   ->   i24_uimm4_2 = (2, 4)
```

Nothing else in the module was modified.

---

## 1. Symptom

On a clean Ghidra 12.1.2, loading language `aeon:LE:32:default` fails during the
SLEIGH compile step. Ghidra 12.x recompiles the `.sla` from the `.slaspec` sources
at language-load time and is stricter about token field definitions than the
Ghidra release this module targeted.

## 2. Root cause

SLEIGH token fields are declared as:

```
<name> = (<startbit>, <endbit>)
```

where bit indices count **from the least-significant bit of the token**, and the
pair is written **lower index first**. Both offending fields were written with the
pair reversed (`(4, 2)` instead of `(2, 4)`), which is not a legal range.

The fields live in the two "immediate" tokens:

* `instr16` — `i16_uimm4_2` (line 45)
* `instr24` — `i24_uimm4_2` (line 95)

## 3. Why the fix is safe — the fields are unused

This is the important part. Neither field is referenced by **any** SLEIGH
constructor. Grepping the whole `data/languages` tree:

```
i16_uimm4_2 : 1 occurrence  (the declaration itself)
i24_uimm4_2 : 1 occurrence  (the declaration itself)
```

Zero uses in `aeon_ORBIS32.sinc`, `aeon_ORBIS32_old.sinc`, `aeon_SPRs.sinc` or
`aeon.slaspec`.

Consequence: correcting the range changes **no instruction encoding, no operand
extraction, and no p-code**. It purely removes an illegal declaration so the
specification compiles. The module's disassembly and decompilation behaviour is
bit-for-bit identical to upstream; upstream simply cannot be *loaded* on 12.1.2.

## 4. Verification performed

| # | Check | Result |
|---|---|---|
| 1 | `diff -r` upstream vs. patched tree | Only `aeon.slaspec` differs; exactly the 2 lines above. No other file differs. |
| 2 | `diff` of `aeon.slaspec` verbatim | `45c45`, `95c95` — nothing else. |
| 3 | Grep for `i16_uimm4_2` / `i24_uimm4_2` in all `.slaspec`/`.sinc` | 1 occurrence each (declaration only) → unused, semantics-preserving. |
| 4 | Stale `aeon.sla` deleted, Ghidra 12.1.2 headless started | SLEIGH recompiled from source with no error. |
| 5 | Headless import, `-processor aeon:LE:32:default`, raw binary, base `0` | `REPORT: Import succeeded`; project created. |
| 6 | Disassembly of firmware region | Decodes cleanly across all three instruction widths: `bg.*` (4 B), `bn.*` (3 B), `bt.*` (2 B), in a single contiguous mixed-width stream. |
| 7 | No generated artifacts committed | Tree contains no `.sla`, `.bin`, `.dll` or `.o`. |

## 5. Known issues NOT fixed (out of scope)

These are upstream behavioural limitations, left untouched deliberately to keep the
patch minimal. They are documented so users are not surprised:

* **`bg.jal` target / flow computation.** Observed to be unreliable in some
  contexts. Do not trust `bg.jal` branch targets without independent confirmation.
* **Linear sweeping desynchronises.** Because 2/3/4-byte instructions are freely
  interleaved (width is chosen by a decoder sub-field at a different bit offset per
  width), a *linear* sweep on any fixed stride — including 4-byte-aligned — walks
  into misaligned data and produces garbage. Always disassemble from a known entry
  point / use recursive descent. In practice a step-1 "disassemble at every address"
  pass is a useful way to *discover* true instruction boundaries, but the resulting
  stream must be validated for contiguity.
* **Unverified / stub constructors.** `aeon_ORBIS32.sinc` contains a number of
  `bn.op*` / `bg.opcode_*` placeholders and several entries annotated
  `hangs on hw` or `invalid?`. Those were left exactly as upstream.

## 6. How to re-derive this patch

```
diff -u upstream/data/languages/aeon.slaspec patched/data/languages/aeon.slaspec
```

Expected output is exactly the two hunks shown in the Summary.
