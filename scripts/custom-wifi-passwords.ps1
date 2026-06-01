try {
    $profiles = (netsh wlan show profiles) | Select-String "\:(.+)$" | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }
    if ($profiles.Count -eq 0) {
        [System.Windows.MessageBox]::Show("No WiFi profiles found.", "WiFi Passwords", "OK", "Information")
        return
    }
    $output = ""
    foreach ($name in $profiles) {
        $info = (netsh wlan show profile name="$name" key=clear)
        $pwLine = $info | Select-String "Key Content"
        if ($pwLine) {
            $pw = ($pwLine -split ":")[1].Trim()
            $output += "$name`n  Password: $pw`n`n"
        } else {
            $output += "$name`n  (open / no password)`n`n"
        }
    }
    Add-Type -AssemblyName PresentationFramework
    $win = New-Object System.Windows.Window
    $win.Title = "Saved WiFi Passwords"
    $win.Width = 500
    $win.Height = 400
    $win.Background = "#1A1A1A"
    $tb = New-Object System.Windows.Controls.TextBox
    $tb.Text = $output
    $tb.Background = "#000000"
    $tb.Foreground = "#E8E8E8"
    $tb.FontFamily = "Consolas"
    $tb.IsReadOnly = $true
    $tb.TextWrapping = "Wrap"
    $tb.VerticalScrollBarVisibility = "Auto"
    $tb.Padding = "10"
    $win.Content = $tb
    $win.ShowDialog() | Out-Null
} catch {
    [System.Windows.MessageBox]::Show("Error: $($_.Exception.Message)", "Error", "OK", "Error")
}
