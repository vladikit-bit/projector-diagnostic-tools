@echo off
setlocal
cd /d C:\firmware_temp
del /q sndproj.gpr sndproj.rep >nul 2>&1
"C:\ghidra_12.1.2_PUBLIC\support\analyzeHeadless.bat" C:\firmware_temp sndproj ^
  -import C:\firmware_temp\aeon_validate\r27_work\snd_full.bin ^
  -processorPath C:\firmware_temp\aeon_validate\ghidra-aeon-master\ghidra-aeon-master\data\languages ^
  -processor AEON:LE:32:default ^
  -scriptPath C:\firmware_temp\aeon_validate\scripts ^
  -postScript SND32_DumpAll.java
