$msg = "GODMODE MERGED 2026 - HIGH RISK`n`nLargest combined tweak script (1400+ lines).`nApplies network, CPU, GPU, registry, BCD changes.`n`nProceed?"
if ([System.Windows.MessageBox]::Show($msg, "HIGH RISK", "YesNo", "Warning") -ne "Yes") { return }
$tmp = "$env:TEMP\godmode-merged.bat"
try {
    Invoke-WebRequest -Uri "$global:RepoBase/batch/godmode-merged-2026.bat" -OutFile $tmp -UseBasicParsing
    Start-Process cmd.exe -ArgumentList "/c `"$tmp`"" -Verb RunAs -Wait
} finally { Remove-Item $tmp -Force -EA SilentlyContinue }
