$msg = "GODMODE WIN10/11 - HIGH RISK`n`nRemoves Edge, OneDrive, Defender, Store, Paint`nDisables 100+ Windows services`nKills many background processes`n`nSome instability reported. Restore point recommended.`n`nProceed?"
if ([System.Windows.MessageBox]::Show($msg, "HIGH RISK", "YesNo", "Warning") -ne "Yes") { return }
$tmp = "$env:TEMP\godmode.bat"
try {
    Invoke-WebRequest -Uri "$global:RepoBase/batch/godmode.bat" -OutFile $tmp -UseBasicParsing
    Start-Process cmd.exe -ArgumentList "/c `"$tmp`"" -Verb RunAs -Wait
} finally { Remove-Item $tmp -Force -EA SilentlyContinue }
