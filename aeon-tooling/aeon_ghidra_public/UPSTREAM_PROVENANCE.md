# Upstream provenance

All credit for this processor module belongs to its original authors. This
repository is a **derived work carrying a two-line compatibility fix only**; it is
published so the fix can be reproduced and reused.

## Source

| Item | Value |
|---|---|
| Project | **ghidra-aeon** (Ghidra processor module for the MStar/MedTek AEON DSP) |
| Branch | `master` |
| Local archive | `C:\Users\k0994\Downloads\ghidra-aeon-master.zip` (84,226 bytes, downloaded 2026-09-08) |
| Extracted to | `C:\firmware_temp\aeon_validate\ghidra-aeon-master\ghidra-aeon-master` |
| Upstream file dates | 2023-02-24 23:23 (uniform, from the archive) |
| License | **Apache License 2.0** (`LICENSE`, 11,357 bytes — carried verbatim) |
| `Module.manifest` | empty (0 bytes) upstream as well — left as-is |

### Caveat on the exact repository URL / commit

The archive is a GitHub "download ZIP of `master`" style snapshot and **contains no
`.git` directory**, so the owning organisation/user and the exact commit SHA are
**not recorded** in the artefact and have not been independently confirmed. The
only metadata available is the archive name (`ghidra-aeon-master.zip`) and the
uniform 2023-02-24 file timestamps.

If you are publishing this, **fill in the canonical URL and commit before release**,
for example:

```
Upstream repository: https://github.com/<owner>/ghidra-aeon
Upstream branch:     master
Upstream commit:     <fill in — not recoverable from the ZIP>
```

Also note the upstream `.gitignore` (contents: `.DS_Store`) is omitted here; it is
not needed for the module and excluding it keeps the diff clean.

## Files: upstream vs. this repository

Verified with `diff -r <upstream> <this>/aeon`:

| File | Status |
|---|---|
| `LICENSE` | unchanged (verbatim) |
| `Module.manifest` | unchanged (empty) |
| `sprs.py` | unchanged (1,175 bytes) |
| `data/build.xml` | unchanged |
| `data/sleighArgs.txt` | unchanged |
| `data/languages/aeon.cspec` | unchanged (3,488 bytes) |
| `data/languages/aeon.ldefs` | unchanged (478 bytes) |
| `data/languages/aeon.pspec` | unchanged (1,197 bytes) |
| **`data/languages/aeon.slaspec`** | **PATCHED — 2 lines** (3,952 bytes both before and after; only the bit-range pairs change) |
| `data/languages/aeon_ORBIS32.sinc` | unchanged (29,526 bytes) |
| `data/languages/aeon_ORBIS32_old.sinc` | unchanged (10,187 bytes) |
| `data/languages/aeon_SPRs.sinc` | unchanged (151,059 bytes) |
| `data/patterns/aeon_BE_patterns.xml` | unchanged |
| `data/patterns/patternconstraints.xml` | unchanged |
| `data/languages/aeon.sla` | **intentionally omitted** (generated artifact — see COMPATIBILITY.md) |
| `.gitignore` | intentionally omitted (upstream contents: `.DS_Store`) |

### The complete functional diff

That is the entire change. Verified verbatim:

```diff
--- upstream/data/languages/aeon.slaspec
+++ patched/data/languages/aeon.slaspec
@@ -42,7 +42,7 @@
 	i16_uimm3_5 = (3, 5)
 	i16_uimm3_13 = (3, 13)
-	i16_uimm4_2 = (4, 2)
+	i16_uimm4_2 = (2, 4)
 	i16_uimm4_12 = (4, 11)
 	i16_uimm5_5 = (5, 5)
@@ -92,7 +92,7 @@
 	i24_uimm3_5 = (3, 7)
 	i24_uimm3_13 = (3, 13)
-	i24_uimm4_2 = (4, 2)
+	i24_uimm4_2 = (2, 4)
 	i24_uimm4_12 = (4, 12)
 	i24_uimm5_5 = (5, 5)
```

(`diff` reports these as `45c45` and `95c95`.)

Both fields are unreferenced by any constructor, so **no decoding semantics
change** — see [PATCH_NOTES.md](PATCH_NOTES.md) §3.

## Local paths used during this work

Recorded so the verification is reproducible on this machine:

| Purpose | Path |
|---|---|
| Installed (patched) module | `C:\ghidra_12.1.2_PUBLIC\Ghidra\Processors\aeon` |
| Public package (this repo) | `C:\firmware_temp\aeon_ghidra_public\aeon` |
| Original upstream ZIP | `C:\Users\k0994\Downloads\ghidra-aeon-master.zip` |
| Upstream extracted | `C:\firmware_temp\aeon_validate\ghidra-aeon-master\ghidra-aeon-master` |
| Modified spec | `C:\ghidra_12.1.2_PUBLIC\Ghidra\Processors\aeon\data\languages\aeon.slaspec` |
| Generated `.sla` (local only, not packaged) | `C:\ghidra_12.1.2_PUBLIC\Ghidra\Processors\aeon\data\languages\aeon.sla` |
| Verification scripts | `C:\firmware_temp\aeon_validate\scripts\` |

## No third-party or proprietary content

This package contains **only** the upstream module's own source files plus the
documentation added here. It contains no firmware images, no device data, no
extracted binaries, no logs and no vendor-proprietary material.
