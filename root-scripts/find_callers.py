import os
import subprocess

print("=== Searching for MI_DEV_IOC_DISP_SET_OUTPUT_TIMING callers ===")

for root, dirs, files in os.walk(r"C:/firmware_temp/display_edid_investigation/extracted"):
    for f in files:
        if f.endswith('.so') or f.endswith('.bin'):
            filepath = os.path.join(root, f)
            try:
                size = os.path.getsize(filepath)
                if os.path.getsize(filepath) < 10*1024*1024:
                    result = subprocess.run(['strings', '-a', filepath], capture_output=True, text=True, timeout=10)
                    output = result.stdout
                    if 'E3004493' in output or '4493' in output or 'SET_OUTPUT_TIMING' in output or '4493' in output:
                        print('Found in: ' + os.path.join(root, f))
        except subprocess.TimeoutExpired:
            print('Timeout: ' + os.path.join(root, f))
        except Exception as e:
            pass

print("Done searching")