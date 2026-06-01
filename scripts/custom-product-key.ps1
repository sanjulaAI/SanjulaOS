try {
    $key = (Get-CimInstance -ClassName SoftwareLicensingService -ErrorAction Stop).OA3xOriginalProductKey
    $os = Get-CimInstance Win32_OperatingSystem
    $msg = "Edition: $($os.Caption)`nVersion: $($os.Version)`n`n"
    if ($key) { $msg += "OEM Product Key:`n$key" }
    else { $msg += "No OEM key found in firmware.`n(Normal if activated via digital license)" }
    [System.Windows.MessageBox]::Show($msg, "Product Key", "OK", "Information")
} catch {
    [System.Windows.MessageBox]::Show("Error: $($_.Exception.Message)", "Error", "OK", "Error")
}
