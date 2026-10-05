@echo off
cd /d C:\firmware_temp\ghidra_snd
"C:\ghidra_12.1.2_PUBLIC\support\analyzeHeadless.bat" C:\firmware_temp\ghidra_snd sndproj4 -process snd_full.bin -noanalysis -scriptPath C:\firmware_temp\gs -postScript SND33_RealCode.java -log C:\firmware_temp\ghidra_snd\run9.log
