$os = Get-CimInstance Win32_OperatingSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$cs = Get-CimInstance Win32_ComputerSystem
$info = @"
Computer:    $env:COMPUTERNAME
User:        $env:USERNAME
OS:          $($os.Caption)
Version:     $($os.Version)
Build:       $($os.BuildNumber)
Install:     $($os.InstallDate)
CPU:         $($cpu.Name)
Cores:       $($cpu.NumberOfCores) physical / $($cpu.NumberOfLogicalProcessors) logical
RAM:         $([math]::Round($cs.TotalPhysicalMemory/1GB,2)) GB
Manufacturer:$($cs.Manufacturer)
Model:       $($cs.Model)
"@
[System.Windows.MessageBox]::Show($info, "System Info", "OK", "Information")
