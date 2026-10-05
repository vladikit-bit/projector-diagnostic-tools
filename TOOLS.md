# Діагностичні та форензик-інструменти дослідження проектору

Кураторський вибір скриптів і утиліт, якими виконувалось дослідження проектора **Thundeal TD.98 Pro** (MStar MT5889, Android 11) у 2026-08…10. Оригінали не переміщувались — тут копії. Повний контекст: [projector-research](https://github.com/vladikit-bit/projector-research), сирі дерева — `C:\firmware_temp` (~2700 скриптів, сюди увійшли ті, що є інструментами, а не одноразовими артефактами фаз).

## Структура

### `device-scans/` — сканування/рекогносцировка пристрою
| Файл | Що робить |
|---|---|
| `td98pro_recon.ps1` | Канонічний read-only ADB-рекон (36 команд): партиції, device-tree, OTA-інфраструктура, MTK-ідентифікація. Написаний 2026-08-08; вивід одразу в таймстамповану папку + zip |
| `td98pro_recon_20260808_124634/` | Повний вивід того скана (36 нумерованих .txt) — еталонний «паспорт» пристрою |
| `projector_diag.ps1` | «Projector Smart Diagnostic Tool v2» (українською) — діагностична сесія 2025-10-31 |
| `Результати команд.txt` | 141 КБ транскрипт PowerShell/adb-shell сесії проти `mt5889:/` (скан проектору) |
| `Скан_проектору.zip` | Архів тієї сесії |

### `root-scripts/` — скрипти з кореня firmware_temp
- **SRAM/bank-свипи R2-DSP** (2026-09-29/30): `bankcap.sh`, `bankscan.sh`, `cap2.sh`, `cell.sh`, `ctx.sh`, `dbg.sh`, `early.sh`, `fulldump.sh`, `full.sh`, `logs.sh`, `mb.sh`, `pcm.sh`, `round.sh`, `rt.sh`, `scan.sh`, `scanb.sh`, `sram.sh`, `st2.sh`, `st3.sh`, `sweep.sh`, `ts.sh`, `type.sh` — зйомка банків SRAM і стану DEC/SND під DTS/AC3 через `/proc/utopia_mdb/audio`.
- **Ghidra headless-ранери**: `ghrun.bat`…`ghrun9.bat`.
- **Статичні аналізатори (Python)**: `find_vtable.py`, `find_vptr_store.py`, `find_caller(s).py`, `find_final.py`, `final_search.py`, `correlate_common.py`, `r18_*.py` (бінарні дифи/трейси епохи R18), `kodi_rpc.py` (керування програванням Kodi через JSON-RPC для A/B-вікон).
- `mx9diag2.py` — діагностика RK3328-боксу (MX9 Pro), побічна лінія.

### `spdif-forensics-tools/` — головний форензик-набір (~230 файлів)
З `spdif_audio_investigation/tools/`:
- **r1–r8 серії** — дифинг mik.ko/utpa2k.ko, vtable-пошук, ioctl-аналіз, relocs.
- **патч-білдери** (кожен відтворює конкретний експеримент лінії DTS): `patch_utpa2k_dts_v1-3.py`, `expA_patch_0x7d.py`, `expB_patch_0x4d8_3_dts_license.py`, `cmd04`-варіанти, `ms12v22_patch_v2/v3.py`, `build_libmi3_v3.py`, `final_digitalmode.py`, `dd_get_dts_license.py`.
- **аудит-скрипти a1–a5**, `closure_*.py`.
- **~60 .asm-виписок** (`mi3_*`, `k_*`, `ut_*`) — кураторські дизасм-фрагменти гейтів.
- `ghidra_scripts/`, `ghidra_scripts_v2/` — скрипти для Grhidra-проектів (аналіз libmi3/utpa2k).

### `display-edid-tools/` — лінія картинки/EDID
- `libmi3_cmd.py`, `libmi3_dev.py`, `ghidra/Hy4Libmi3Probe.java` — зондування libmi3 (hy4_review).
- `extract_hwc.py` — витяг hwcomposer-артефактів; `measure_frame.py`, `measure_ref.py` (2026-10-03) — вимірювання таймінгу кадру для DV-калібрування.

### `factory-menu-tools/` — розбір Factory Menu APK (androguard; 2026-09-26)
`scripts/` + власні `tools/` (bандл python-бібліотек не включався).

### `adb-capture/` — обгортки ADB-зйомок
`r16_adb.sh` — **канонічний reconnect-обгортник adb** (його відтворено у SKILL.md), `r17_capture.sh`, `r30_cap*.sh`, `r30_realkodi_*.sh`, `r38_capture.sh`, `r41_scan.py`.

### `re-tmp-analysis/` — RE-розбір прошивки (робоча папка C:\tmp)
- `spdif.h`, `spdif2.h`, `spdifenc.c` (2025-09-12) — вихідники SPDIF-енкодера.
- Python/C++ утиліти аналізу, текстові виводи Grhidra-декомпіляцій (`ghidra_v3/v4.txt`, `ota_*`, `key_classes_output.txt`, `all_recovered_symbols.txt`, `detailed_chain_dump.txt` — RE OTA/upgrade-механізму і AES-ключів).
- `factory.db`, `user_setting.db` — зняті з пристрою бази.
- Бінарники (APK/`.img`/`.ko`) НЕ включались — лишаються локально.

### `aeon-tooling/` — інструментарій MStar AEON (R2 DSP)
- `aeon-isa/` — ISA-екстрактор (LD_PRELOAD у aeon-elf-as).
- `aeon_ghidra_public/` — запакований open-source ghidra-aeon модуль, допатчений під Ghidra 12.1.2 (README/COMPATIBILITY/PATCH_NOTES/UPSTREAM_PROVENANCE — всередині).
- `reko_run/`, `image.reko`, `gs/`, `sndlist/` — Reko-проект декомпіляції SND-образу і супутнє.

### `skill-mstar-dec-r2-log/SKILL.md` — перевикористовуваний навик
Захоплення/інтерпретація логів MStar AEON DEC/SND R2 та DSP-SRAM через `/proc/utopia_mdb/audio` — методологічний квінтесенція всієї DTS-лінії.

## Чого тут немає (і де шукати)
- Великих логів/дампів (`logcat.txt` 4.9 МБ, `during_ac3_logcat.txt`, `snd32_raw.txt` 11 МБ, vendor_full_dump 459 МБ, super/boot образи) — локально: `C:\Android\platform-tools-latest-windows\platform-tools\`, `C:\firmware_temp\`.
- Grhidra-проектів (.rep, 20–227 МБ) — локально `C:\firmware_temp\ghidra_*`.
- Стокових platform-tools (adb.exe тощо) — офіційний Android SDK.
