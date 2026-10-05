@echo off
cd /d C:\firmware_temp\ghidra_snd
"C:\ghidra_12.1.2_PUBLIC\support\analyzeHeadless.bat" C:\firmware_temp\ghidra_snd sndproj4 -process snd_full.bin -noanalysis -postScript SND33_RealCode.java -log C:\firmware_temp\ghidra_snd\run8.log
