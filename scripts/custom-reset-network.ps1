ipconfig /flushdns | Out-Null
ipconfig /release | Out-Null
ipconfig /renew | Out-Null
netsh winsock reset | Out-Null
netsh int ip reset | Out-Null
netsh interface ipv4 reset | Out-Null
netsh interface ipv6 reset | Out-Null
[System.Windows.MessageBox]::Show("Network reset. Reboot recommended.", "Network", "OK", "Information")
