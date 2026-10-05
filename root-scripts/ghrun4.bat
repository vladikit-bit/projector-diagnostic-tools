@echo off
cd /d C:\firmware_temp\ghidra_snd
"C:\ghidra_12.1.2_PUBLIC\support\analyzeHeadless.bat" C:\firmware_temp\ghidra_snd sndproj3 -processor aeon:LE:32:default -import C:\firmware_temp\aeon_validate\r27_work\snd_full.bin -scriptPath C:\firmware_temp\aeon_validate\scripts -postScript SND32_DumpAll.java -log C:\firmware_temp\ghidra_snd\run4.log -overwrite
