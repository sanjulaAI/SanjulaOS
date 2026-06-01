$msg = "AUTO BIOS - EXTREME RISK`n`nNeeds SCEWIN_64.exe in PATH.`nDisables Secure Boot, TPM, BME DMA`nModifies BIOS directly.`nCAN BRICK YOUR MOTHERBOARD.`n`nWindows 11 won't boot after this.`nAuthor warns Gigabyte boards have issues.`n`nAre you absolutely sure?"
if ([System.Windows.MessageBox]::Show($msg, "EXTREME RISK", "YesNo", "Warning") -ne "Yes") { return }
if ([System.Windows.MessageBox]::Show("LAST CHANCE. SCEWIN_64.exe must be ready.`n`nReally proceed?", "Final Confirm", "YesNo", "Warning") -ne "Yes") { return }
$tmp = "$env:TEMP\auto-bios.bat"
try {
    Invoke-WebRequest -Uri "$global:RepoBase/batch/auto-bios.bat" -OutFile $tmp -UseBasicParsing
    Start-Process cmd.exe -ArgumentList "/c `"$tmp`"" -Verb RunAs -Wait
} finally { Remove-Item $tmp -Force -EA SilentlyContinue }
