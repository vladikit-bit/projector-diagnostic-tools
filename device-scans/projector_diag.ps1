# ===============================================
#  Projector Smart Diagnostic Tool v2 (PowerShell)
# ===============================================

$ErrorActionPreference = "Continue"
$adb = Join-Path $PSScriptRoot "adb.exe"

Write-Host "=================================================="
Write-Host "     📺 Projector Smart Diagnostic Tool v2"
Write-Host "==================================================`n"

if (-not (Test-Path $adb)) {
    Write-Host "❌ Не знайдено adb.exe у тій самій теці!`n"
    Write-Host "Помісти скрипт у папку з adb.exe або додай adb у PATH."
    exit 1
}

# Перевіримо, чи є пристрій
Write-Host "🔌 Перевірка з'єднання з проектором..."
$devices = & $adb devices
if ($devices -notmatch "device`r?`n") {
    Write-Host "⚠️  Пристрій не знайдено. Перевір ADB Debugging на проекторі!"
    Write-Host "Спробуй команду:  .\adb connect <IP_проектора>`n"
    exit 1
}

# Створюємо теку для результатів
$ts = Get-Date -Format "yyyyMMdd_HHmmss"
$outdir = Join-Path $PSScriptRoot "diag_$ts"
New-Item -ItemType Directory -Force -Path $outdir | Out-Null
Write-Host "📂 Результати будуть збережені в $outdir`n"

# Основні діагностичні команди
$cmds = @(
    "shell getprop",
    "shell uname -a",
    "shell cat /proc/cpuinfo",
    "shell cat /proc/meminfo",
    "shell df -h",
    "shell ps -A",
    "shell logcat -d | tail -n 500",
    "shell dmesg | tail -n 300"
)

foreach ($cmd in $cmds) {
    $safe = ($cmd -replace '[^\w]', '_')
    $outfile = Join-Path $outdir ("result_" + $safe + ".txt")
    Write-Host "▶️  Виконую: $cmd"
    try {
        & $adb $cmd | Out-File -Encoding UTF8 $outfile
    } catch {
        Write-Host "⚠️  Помилка під час виконання $cmd"
    }
}

Write-Host "`n✅ Діагностика завершена!"
Write-Host "Результати у теці: $outdir"
pause
