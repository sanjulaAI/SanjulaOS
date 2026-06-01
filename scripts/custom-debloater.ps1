$msg = "PERMANENT DEBLOATER`n`nRemoves these for ALL users (won't come back after updates):`n3D Viewer, Bing apps, Cortana, Solitaire, Skype, Maps, Xbox, Mail, Teams, OneNote, etc.`n`nProceed?"
if ([System.Windows.MessageBox]::Show($msg, "Confirm", "YesNo", "Warning") -ne "Yes") { return }
$tmp = "$env:TEMP\debloater.bat"
try {
    Invoke-WebRequest -Uri "$global:RepoBase/batch/permanent-debloater.bat" -OutFile $tmp -UseBasicParsing
    Start-Process cmd.exe -ArgumentList "/c `"$tmp`"" -Verb RunAs -Wait
} finally { Remove-Item $tmp -Force -EA SilentlyContinue }
