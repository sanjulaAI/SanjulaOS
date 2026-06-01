Start-Process winget -ArgumentList "source reset --force" -Wait -NoNewWindow
Start-Process winget -ArgumentList "source update" -Wait -NoNewWindow
[System.Windows.MessageBox]::Show("Winget sources reset.", "Winget", "OK", "Information")
