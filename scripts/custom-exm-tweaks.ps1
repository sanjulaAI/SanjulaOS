$msg = "EXM PREMIUM TWEAKS - HIGH RISK`n`nWill DISABLE UAC (security risk)`nChange BCD boot config (can prevent boot)`nDisable CPU power management`nDisable Hyper-V / virtualization`nDisable System Restore`n`nMostly IRREVERSIBLE. Make a restore point first.`n`nProceed?"
if ([System.Windows.MessageBox]::Show($msg, "HIGH RISK", "YesNo", "Warning") -ne "Yes") { return }
$tmp = "$env:TEMP\exm.bat"
try {
    Invoke-WebRequest -Uri "$global:RepoBase/batch/exm-premium-tweaks.bat" -OutFile $tmp -UseBasicParsing
    Start-Process cmd.exe -ArgumentList "/c `"$tmp`"" -Verb RunAs -Wait
} finally { Remove-Item $tmp -Force -EA SilentlyContinue }
