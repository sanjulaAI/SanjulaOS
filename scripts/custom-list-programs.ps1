$output = "$env:USERPROFILE\Desktop\installed_programs.txt"
$paths = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
)
$progs = foreach ($p in $paths) {
    Get-ItemProperty $p -ErrorAction SilentlyContinue |
        Where-Object { $_.DisplayName -and -not $_.SystemComponent } |
        Select-Object DisplayName, DisplayVersion, Publisher
}
$progs = $progs | Sort-Object DisplayName -Unique
$progs | Format-Table -AutoSize | Out-String | Set-Content $output
[System.Windows.MessageBox]::Show("Exported $($progs.Count) programs to:`n$output", "Installed Apps", "OK", "Information")
Start-Process notepad.exe $output
