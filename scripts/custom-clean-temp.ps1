$paths = @("$env:TEMP\*", "C:\Windows\Temp\*", "C:\Windows\Prefetch\*")
$freed = 0
foreach ($p in $paths) {
    try {
        $size = (Get-ChildItem $p -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
        Remove-Item $p -Recurse -Force -ErrorAction SilentlyContinue
        $freed += $size
    } catch {}
}
$mb = [math]::Round($freed / 1MB, 2)
[System.Windows.MessageBox]::Show("Temp cleaned. ~$mb MB freed.", "Cleanup", "OK", "Information")
