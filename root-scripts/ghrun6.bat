@echo off
cd /d C:\firmware_temp\ghidra_snd
"C:\ghidra_12.1.2_PUBLIC\support\analyzeHeadless.bat" C:\firmware_temp\ghidra_snd sndproj3 -process snd_full.bin -noanalysis -postScript SND32_DumpAll.java -log C:\firmware_temp\ghidra_snd\run6.log
