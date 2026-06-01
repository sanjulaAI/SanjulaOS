$msg = "NUCLEAR PROCESS KILLER - HIGH RISK`n`nWill PERMANENTLY disable:`n- Windows Update`n- Windows Defender`n- 80+ services and 100+ processes`n`nYou'll have NO security patches and NO antivirus after this.`nOnly do this if you have 3rd party AV.`n`nBackup created at C:\ProcessKillerBackup`n`nProceed?"
if ([System.Windows.MessageBox]::Show($msg, "HIGH RISK", "YesNo", "Warning") -ne "Yes") { return }
$tmp = "$env:TEMP\nuclear.bat"
try {
    Invoke-WebRequest -Uri "$global:RepoBase/batch/nuclear-process-killer.bat" -OutFile $tmp -UseBasicParsing
    Start-Process cmd.exe -ArgumentList "/c `"$tmp`"" -Verb RunAs -Wait
} finally { Remove-Item $tmp -Force -EA SilentlyContinue }
