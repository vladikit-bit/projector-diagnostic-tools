```powershell
$ErrorActionPreference = "Continue"

# ADB is expected to be in the current directory.
$Adb = ".\adb.exe"

if (-not (Test-Path $Adb)) {
    Write-Error "adb.exe was not found in the current directory: $PWD"
    Write-Host "Place td98pro_recon.ps1 next to adb.exe and run it from that directory."
    exit 1
}

# Create timestamped output directory.
$OutDir = ".\td98pro_recon_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
New-Item -ItemType Directory -Path $OutDir -Force | Out-Null

function Save-AdbCommand {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string]$Command
    )

    Write-Host "Collecting $Name ..."

    try {
        & $Adb shell $Command 2>&1 |
            Out-File -Encoding utf8 "$OutDir\$Name.txt"
    }
    catch {
        $_ | Out-File -Encoding utf8 "$OutDir\$Name.txt"
    }
}

Write-Host ""
Write-Host "==============================================="
Write-Host " TD98PRO read-only ADB reconnaissance"
Write-Host "==============================================="
Write-Host "ADB:    $Adb"
Write-Host "Output: $OutDir"
Write-Host ""

# ------------------------------------------------
# 00 - ADB connection
# ------------------------------------------------

Write-Host "Checking ADB connection..."

& $Adb get-state 2>&1 |
    Out-File -Encoding utf8 "$OutDir\00_adb_state.txt"

& $Adb devices -l 2>&1 |
    Out-File -Encoding utf8 "$OutDir\00_adb_devices.txt"

Save-AdbCommand "01_id" "id"

# ------------------------------------------------
# 01 - Android / platform identification
# ------------------------------------------------

Save-AdbCommand "02_getprop" "getprop"
Save-AdbCommand "03_uname" "uname -a"
Save-AdbCommand "04_cmdline" "cat /proc/cmdline"
Save-AdbCommand "05_version" "cat /proc/version"

# ------------------------------------------------
# 02 - CPU / memory
# ------------------------------------------------

Save-AdbCommand "06_cpuinfo" "cat /proc/cpuinfo"
Save-AdbCommand "07_meminfo" "cat /proc/meminfo"

# ------------------------------------------------
# 03 - Partitions / block devices
# ------------------------------------------------

Save-AdbCommand "08_partitions" "cat /proc/partitions"
Save-AdbCommand "09_mtd" "cat /proc/mtd"
Save-AdbCommand "10_mounts" "cat /proc/mounts"
Save-AdbCommand "11_filesystems" "cat /proc/filesystems"

Save-AdbCommand "12_dev_block" "ls -la /dev/block"
Save-AdbCommand "13_dev_block_platform" "ls -la /dev/block/platform 2>/dev/null"

# ------------------------------------------------
# 04 - Device Tree
# ------------------------------------------------

Save-AdbCommand "14_dt_root" "ls -la /proc/device-tree 2>/dev/null"
Save-AdbCommand "15_dt_compatible" "cat /proc/device-tree/compatible 2>/dev/null"
Save-AdbCommand "16_dt_model" "cat /proc/device-tree/model 2>/dev/null"

# ------------------------------------------------
# 05 - Kernel modules / hardware
# ------------------------------------------------

Save-AdbCommand "17_modules" "cat /proc/modules"
Save-AdbCommand "18_sys_class" "ls -la /sys/class"

# Keep this deliberately bounded.
Save-AdbCommand "19_sys_devices" "find /sys/devices -maxdepth 3 -type d 2>/dev/null | head -n 500"

# ------------------------------------------------
# 06 - Processes / Android services
# ------------------------------------------------

Save-AdbCommand "20_processes" "ps -A"
Save-AdbCommand "21_services" "service list"

# ------------------------------------------------
# 07 - Filesystem overview
# ------------------------------------------------

Save-AdbCommand "22_df" "df -h"
Save-AdbCommand "23_mount_command" "mount"

# ------------------------------------------------
# 08 - Boot / recovery
# ------------------------------------------------

Save-AdbCommand "24_boot_recovery" "ls -la /boot /recovery 2>/dev/null"

# ------------------------------------------------
# 09 - OTA / update infrastructure
# ------------------------------------------------

Save-AdbCommand "25_update_processes" "ps -A | grep -Ei 'update|ota|upgrade|recovery|install'"

Save-AdbCommand "26_update_files" "find /system /vendor /product /odm 2>/dev/null -maxdepth 4 -type f \( -iname '*update*' -o -iname '*ota*' -o -iname '*upgrade*' \) 2>/dev/null"

# ------------------------------------------------
# 10 - Relevant Android properties
# ------------------------------------------------

Save-AdbCommand "27_relevant_properties" "getprop | grep -Ei 'ro\.product|ro\.board|ro\.hardware|ro\.boot|ro\.build|ro\.mediatek|ro\.vendor|ota|update|partition'"

# ------------------------------------------------
# 11 - Update / recovery configuration
# ------------------------------------------------

Save-AdbCommand "28_update_config" "find /system /vendor /product /odm 2>/dev/null -type f \( -iname '*.rc' -o -iname '*.xml' -o -iname '*.prop' -o -iname '*.conf' -o -iname '*.ini' \) 2>/dev/null | grep -Ei 'update|ota|recovery|boot|partition'"

# ------------------------------------------------
# 12 - Basic storage directory inventory
# ------------------------------------------------

Save-AdbCommand "29_system_root" "ls -la /system 2>/dev/null"
Save-AdbCommand "30_vendor_root" "ls -la /vendor 2>/dev/null"
Save-AdbCommand "31_product_root" "ls -la /product 2>/dev/null"
Save-AdbCommand "32_odm_root" "ls -la /odm 2>/dev/null"

# ------------------------------------------------
# 13 - Android build / vendor identity
# ------------------------------------------------

Save-AdbCommand "33_build_fingerprint" "getprop ro.build.fingerprint"
Save-AdbCommand "34_product_identity" "getprop ro.product.device; getprop ro.product.name; getprop ro.product.model; getprop ro.product.manufacturer; getprop ro.board.platform"
Save-AdbCommand "35_mtk_identity" "getprop ro.mediatek.platform; getprop ro.hardware; getprop ro.boot.hardware; getprop ro.boot.bootdevice"

# ------------------------------------------------
# Finish
# ------------------------------------------------

Write-Host ""
Write-Host "Reconnaissance complete."
Write-Host "Output directory:"
Write-Host "  $OutDir"
Write-Host ""

# Create ZIP locally.
$Zip = "$OutDir.zip"

try {
    Compress-Archive -Path "$OutDir\*" -DestinationPath $Zip -Force
    Write-Host "Archive:"
    Write-Host "  $Zip"
}
catch {
    Write-Warning "Could not create ZIP archive: $($_.Exception.Message)"
}

Write-Host ""
Write-Host "No files were intentionally written to the projector."
Write-Host "All collected data was saved locally on this PC."
```
