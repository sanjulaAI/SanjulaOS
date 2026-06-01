ipconfig /flushdns | Out-Null
[System.Windows.MessageBox]::Show("DNS cache flushed.", "Network", "OK", "Information")
