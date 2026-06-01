Get-Process explorer -EA SilentlyContinue | Stop-Process -Force
Start-Sleep -Milliseconds 500
if (-not (Get-Process explorer -EA SilentlyContinue)) { Start-Process explorer.exe }
