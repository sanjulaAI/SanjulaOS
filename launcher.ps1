# SanjulaOS v1.0 - JARVIS Edition

$global:RepoBase = "https://raw.githubusercontent.com/sanjulaAI/SanjulaOS/main"

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Re-launching as Administrator..." -ForegroundColor Yellow
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm $global:RepoBase/launcher.ps1 | iex`""
    exit
}

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

# Load the tweak engine once
$tweakEngineCode = Invoke-RestMethod -Uri "$global:RepoBase/scripts/tweak-engine.ps1" -UseBasicParsing
Invoke-Expression $tweakEngineCode

function Invoke-RemoteScript {
    param([string]$Path)
    try {
        $code = Invoke-RestMethod -Uri "$global:RepoBase/$Path" -UseBasicParsing
        Invoke-Expression $code
    } catch {
        [System.Windows.MessageBox]::Show("Failed: $Path`n$($_.Exception.Message)", "Error", "OK", "Error")
    }
}

function Get-RemoteJson {
    param([string]$Path)
    try { return Invoke-RestMethod -Uri "$global:RepoBase/$Path" -UseBasicParsing } catch { return $null }
}

# Time-based greeting
function Get-Greeting {
    $h = (Get-Date).Hour
    if ($h -lt 12) { return "Good Morning, Master" }
    if ($h -lt 17) { return "Good Afternoon, Master" }
    if ($h -lt 21) { return "Good Evening, Master" }
    return "Working Late, Master"
}

$xamlString = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="SanjulaOS" Height="760" Width="1180"
        WindowStartupLocation="CenterScreen"
        Background="Black">
    <Window.Resources>
        <LinearGradientBrush x:Key="ChromeBrush" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#E8E8E8" Offset="0"/>
            <GradientStop Color="#A8A8A8" Offset="0.5"/>
            <GradientStop Color="#FFFFFF" Offset="1"/>
        </LinearGradientBrush>
        <LinearGradientBrush x:Key="JarvisAccent" StartPoint="0,0" EndPoint="1,0">
            <GradientStop Color="#00D9FF" Offset="0"/>
            <GradientStop Color="#60CDFF" Offset="0.5"/>
            <GradientStop Color="#00D9FF" Offset="1"/>
        </LinearGradientBrush>
        <LinearGradientBrush x:Key="BrickGradient" StartPoint="0,0" EndPoint="0,1">
            <GradientStop Color="#2A2A2A" Offset="0"/>
            <GradientStop Color="#0F0F0F" Offset="1"/>
        </LinearGradientBrush>
        <LinearGradientBrush x:Key="BrickGradientHover" StartPoint="0,0" EndPoint="0,1">
            <GradientStop Color="#3A3A4A" Offset="0"/>
            <GradientStop Color="#1F2F3F" Offset="1"/>
        </LinearGradientBrush>
        <LinearGradientBrush x:Key="RiskyBrickGradient" StartPoint="0,0" EndPoint="0,1">
            <GradientStop Color="#3A1F1F" Offset="0"/>
            <GradientStop Color="#0F0505" Offset="1"/>
        </LinearGradientBrush>
        <LinearGradientBrush x:Key="ChromeButton" StartPoint="0,0" EndPoint="0,1">
            <GradientStop Color="#3A3A3A" Offset="0"/>
            <GradientStop Color="#1A1A1A" Offset="1"/>
        </LinearGradientBrush>

        <Style x:Key="ChromeBtn" TargetType="Button">
            <Setter Property="Background" Value="{StaticResource ChromeButton}"/>
            <Setter Property="Foreground" Value="#E8E8E8"/>
            <Setter Property="BorderBrush" Value="#888888"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="14,8"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="4">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="BorderBrush" Value="#00D9FF"/>
                                <Setter Property="Foreground" Value="#FFFFFF"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Small Apply/Revert button -->
        <Style x:Key="TweakActionBtn" TargetType="Button">
            <Setter Property="Width" Value="70"/>
            <Setter Property="Height" Value="28"/>
            <Setter Property="Margin" Value="4,0,0,0"/>
            <Setter Property="Background" Value="#1A1A1A"/>
            <Setter Property="Foreground" Value="#CCCCCC"/>
            <Setter Property="BorderBrush" Value="#555555"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="FontSize" Value="10"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="3">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#003344"/>
                                <Setter Property="BorderBrush" Value="#00D9FF"/>
                                <Setter Property="Foreground" Value="#FFFFFF"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Brick for tools tab -->
        <Style x:Key="BrickBtn" TargetType="Button">
            <Setter Property="Width" Value="155"/>
            <Setter Property="Height" Value="75"/>
            <Setter Property="Margin" Value="6"/>
            <Setter Property="Background" Value="{StaticResource BrickGradient}"/>
            <Setter Property="Foreground" Value="#E8E8E8"/>
            <Setter Property="BorderBrush" Value="#555555"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="FontSize" Value="11"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Name="OB" Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="6">
                            <Border.Effect>
                                <DropShadowEffect Color="#00D9FF" BlurRadius="0" ShadowDepth="0" Opacity="0"/>
                            </Border.Effect>
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center" TextBlock.TextAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="OB" Property="Background" Value="{StaticResource BrickGradientHover}"/>
                                <Setter Property="BorderBrush" Value="#00D9FF"/>
                                <Setter Property="Foreground" Value="#FFFFFF"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Risky brick - red glow -->
        <Style x:Key="RiskyBrickBtn" TargetType="Button" BasedOn="{StaticResource BrickBtn}">
            <Setter Property="Background" Value="{StaticResource RiskyBrickGradient}"/>
            <Setter Property="BorderBrush" Value="#883333"/>
            <Setter Property="Foreground" Value="#FFCCCC"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Name="OB" Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="6">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center" TextBlock.TextAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="BorderBrush" Value="#FF4444"/>
                                <Setter Property="Foreground" Value="#FFFFFF"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid>
        <Grid.Background>
            <ImageBrush ImageSource="https://raw.githubusercontent.com/sanjulaAI/SanjulaOS/main/SILVER_SURFER.png" Stretch="UniformToFill"/>
        </Grid.Background>

        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="140"/>
        </Grid.RowDefinitions>

        <!-- Header -->
        <Grid Grid.Row="0" Margin="20,15,20,5">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="Auto"/>
            </Grid.ColumnDefinitions>
            <StackPanel Grid.Column="0" Orientation="Vertical">
                <TextBlock Text="SANJULA.OS" FontSize="30" FontWeight="Light" Foreground="{StaticResource ChromeBrush}" Margin="0,0,0,-4">
                    <TextBlock.Effect>
                        <DropShadowEffect Color="#00D9FF" BlurRadius="20" ShadowDepth="0" Opacity="0.6"/>
                    </TextBlock.Effect>
                </TextBlock>
                <TextBlock Name="GreetingText" Text="Initializing..." FontSize="12" Foreground="#00D9FF" Margin="3,0,0,0" FontStyle="Italic">
                    <TextBlock.Effect>
                        <DropShadowEffect Color="#00D9FF" BlurRadius="10" ShadowDepth="0" Opacity="0.5"/>
                    </TextBlock.Effect>
                </TextBlock>
            </StackPanel>
            <StackPanel Grid.Column="1" Orientation="Vertical" HorizontalAlignment="Right">
                <TextBlock Name="ClockText" FontSize="28" FontWeight="Light" Foreground="{StaticResource ChromeBrush}" TextAlignment="Right" FontFamily="Segoe UI Light">
                    <TextBlock.Effect>
                        <DropShadowEffect Color="White" BlurRadius="20" ShadowDepth="0" Opacity="0.5"/>
                    </TextBlock.Effect>
                </TextBlock>
                <TextBlock Name="DateText" FontSize="11" Foreground="#999999" TextAlignment="Right" Margin="0,2,2,0"/>
            </StackPanel>
        </Grid>

        <!-- Animated accent line -->
        <Rectangle Grid.Row="1" Height="1" Margin="20,0,20,5" Fill="{StaticResource JarvisAccent}">
            <Rectangle.Effect>
                <DropShadowEffect Color="#00D9FF" BlurRadius="8" ShadowDepth="0" Opacity="0.7"/>
            </Rectangle.Effect>
        </Rectangle>

        <Border Grid.Row="2" Margin="15,5,15,5" CornerRadius="8" HorizontalAlignment="Left" Width="600">
            <Border.Background><SolidColorBrush Color="#000000" Opacity="0.6"/></Border.Background>
            <Border.BorderBrush><SolidColorBrush Color="#00D9FF" Opacity="0.4"/></Border.BorderBrush>
            <Border.BorderThickness>1</Border.BorderThickness>

            <TabControl Background="Transparent" BorderThickness="0" Padding="0" Margin="5">
                <TabControl.Resources>
                    <Style TargetType="TabItem">
                        <Setter Property="Background" Value="Transparent"/>
                        <Setter Property="Foreground" Value="#AAAAAA"/>
                        <Setter Property="Padding" Value="14,8"/>
                        <Setter Property="FontSize" Value="11"/>
                        <Setter Property="FontWeight" Value="SemiBold"/>
                        <Setter Property="Template">
                            <Setter.Value>
                                <ControlTemplate TargetType="TabItem">
                                    <Border Name="B" Background="{TemplateBinding Background}" Padding="{TemplateBinding Padding}" CornerRadius="4,4,0,0" Margin="2,0" BorderBrush="Transparent" BorderThickness="0,0,0,2">
                                        <ContentPresenter ContentSource="Header" HorizontalAlignment="Center" VerticalAlignment="Center" TextBlock.Foreground="{TemplateBinding Foreground}"/>
                                    </Border>
                                    <ControlTemplate.Triggers>
                                        <Trigger Property="IsSelected" Value="True">
                                            <Setter TargetName="B" Property="Background" Value="#1A1A1A"/>
                                            <Setter TargetName="B" Property="BorderBrush" Value="#00D9FF"/>
                                            <Setter Property="Foreground" Value="#FFFFFF"/>
                                        </Trigger>
                                        <Trigger Property="IsMouseOver" Value="True">
                                            <Setter Property="Foreground" Value="#00D9FF"/>
                                        </Trigger>
                                    </ControlTemplate.Triggers>
                                </ControlTemplate>
                            </Setter.Value>
                        </Setter>
                    </Style>
                </TabControl.Resources>

                <TabItem Header="INSTALL APPS">
                    <Grid Margin="0,5,0,0">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>
                        <ScrollViewer Grid.Row="0" VerticalScrollBarVisibility="Auto">
                            <StackPanel Name="AppsPanel" Margin="15"/>
                        </ScrollViewer>
                        <StackPanel Grid.Row="1" Orientation="Horizontal" Margin="15,10">
                            <Button Name="InstallBtn" Content="INSTALL" Style="{StaticResource ChromeBtn}" Margin="0,0,8,0"/>
                            <Button Name="UninstallBtn" Content="UNINSTALL" Style="{StaticResource ChromeBtn}" Margin="0,0,8,0"/>
                            <Button Name="FixWingetBtn" Content="FIX WINGET" Style="{StaticResource ChromeBtn}"/>
                        </StackPanel>
                    </Grid>
                </TabItem>

                <TabItem Header="TWEAKS">
                    <Grid Margin="0,5,0,0">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>
                        <ScrollViewer Grid.Row="0" VerticalScrollBarVisibility="Auto">
                            <StackPanel Name="TweaksPanel" Margin="15"/>
                        </ScrollViewer>
                        <StackPanel Grid.Row="1" Orientation="Horizontal" Margin="15,10">
                            <Button Name="ApplyAllSafeBtn" Content="APPLY ALL SAFE" Style="{StaticResource ChromeBtn}" Margin="0,0,8,0"/>
                            <Button Name="RevertAllBtn" Content="REVERT ALL" Style="{StaticResource ChromeBtn}"/>
                        </StackPanel>
                    </Grid>
                </TabItem>

                <TabItem Header="MONITOR">
                    <ScrollViewer VerticalScrollBarVisibility="Auto">
                        <StackPanel Margin="20">
                            <TextBlock Text="LIVE SYSTEM STATS" Foreground="#00D9FF" FontSize="14" FontWeight="Bold" Margin="0,0,0,15"/>
                            <TextBlock Name="CpuLabel" Foreground="#E8E8E8" FontSize="13" Margin="0,5,0,3"/>
                            <ProgressBar Name="CpuBar" Height="14" Maximum="100" Foreground="#00D9FF" Background="#22FFFFFF" BorderThickness="0"/>
                            <TextBlock Name="RamLabel" Foreground="#E8E8E8" FontSize="13" Margin="0,12,0,3"/>
                            <ProgressBar Name="RamBar" Height="14" Maximum="100" Foreground="#60CDFF" Background="#22FFFFFF" BorderThickness="0"/>
                            <TextBlock Name="DiskLabel" Foreground="#E8E8E8" FontSize="13" Margin="0,12,0,3"/>
                            <ProgressBar Name="DiskBar" Height="14" Maximum="100" Foreground="#A0A0A0" Background="#22FFFFFF" BorderThickness="0"/>
                            <TextBlock Text="NETWORK" Foreground="#00D9FF" FontSize="14" FontWeight="Bold" Margin="0,20,0,8"/>
                            <Border Background="#33000000" CornerRadius="4">
                                <TextBox Name="NetworkInfo" Background="Transparent" Foreground="#E8E8E8" FontFamily="Consolas" FontSize="11" BorderThickness="0" IsReadOnly="True" Padding="10" TextWrapping="Wrap" Text="Loading..."/>
                            </Border>
                            <StackPanel Orientation="Horizontal" Margin="0,15,0,0">
                                <Button Name="RefreshStatsBtn" Content="REFRESH" Style="{StaticResource ChromeBtn}" Margin="0,0,8,0"/>
                                <Button Name="SpeedTestBtn" Content="PING TEST" Style="{StaticResource ChromeBtn}"/>
                            </StackPanel>
                        </StackPanel>
                    </ScrollViewer>
                </TabItem>

                <TabItem Header="TOOLS">
                    <ScrollViewer VerticalScrollBarVisibility="Auto">
                        <StackPanel Name="CustomPanel" Margin="8"/>
                    </ScrollViewer>
                </TabItem>
            </TabControl>
        </Border>

        <Border Grid.Row="3" Margin="15,5,15,15" CornerRadius="8" HorizontalAlignment="Left" Width="600">
            <Border.Background><SolidColorBrush Color="#000000" Opacity="0.75"/></Border.Background>
            <Border.BorderBrush><SolidColorBrush Color="#00D9FF" Opacity="0.4"/></Border.BorderBrush>
            <Border.BorderThickness>1</Border.BorderThickness>
            <ScrollViewer VerticalScrollBarVisibility="Auto">
                <TextBox Name="LogBox" Background="Transparent" Foreground="#00D9FF" FontFamily="Consolas" FontSize="11" BorderThickness="0" IsReadOnly="True" TextWrapping="Wrap" Padding="12" Text="// SANJULA.OS ONLINE"/>
            </ScrollViewer>
        </Border>
    </Grid>
</Window>
'@

$stringReader = New-Object System.IO.StringReader $xamlString
$xmlReader = [System.Xml.XmlReader]::Create($stringReader)
$window = [Windows.Markup.XamlReader]::Load($xmlReader)

# Find controls
$AppsPanel        = $window.FindName("AppsPanel")
$TweaksPanel      = $window.FindName("TweaksPanel")
$CustomPanel      = $window.FindName("CustomPanel")
$LogBox           = $window.FindName("LogBox")
$InstallBtn       = $window.FindName("InstallBtn")
$UninstallBtn     = $window.FindName("UninstallBtn")
$FixWingetBtn     = $window.FindName("FixWingetBtn")
$ApplyAllSafeBtn  = $window.FindName("ApplyAllSafeBtn")
$RevertAllBtn     = $window.FindName("RevertAllBtn")
$ClockText        = $window.FindName("ClockText")
$DateText         = $window.FindName("DateText")
$GreetingText     = $window.FindName("GreetingText")
$CpuBar           = $window.FindName("CpuBar")
$RamBar           = $window.FindName("RamBar")
$DiskBar          = $window.FindName("DiskBar")
$CpuLabel         = $window.FindName("CpuLabel")
$RamLabel         = $window.FindName("RamLabel")
$DiskLabel        = $window.FindName("DiskLabel")
$NetworkInfo      = $window.FindName("NetworkInfo")
$RefreshStatsBtn  = $window.FindName("RefreshStatsBtn")
$SpeedTestBtn     = $window.FindName("SpeedTestBtn")

# Set greeting
$GreetingText.Text = "$($env:USERNAME.ToUpper()) :: $(Get-Greeting)"

# Clock
$timer = New-Object System.Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromSeconds(1)
$timer.Add_Tick({
    $ClockText.Text = Get-Date -Format "HH:mm:ss"
    $DateText.Text  = (Get-Date -Format "dddd, MMM dd yyyy").ToUpper()
})
$timer.Start()
$ClockText.Text = Get-Date -Format "HH:mm:ss"
$DateText.Text  = (Get-Date -Format "dddd, MMM dd yyyy").ToUpper()

# System stats
function Update-SystemStats {
    try {
        $cpu = (Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
        $os  = Get-CimInstance Win32_OperatingSystem
        $totalRam = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
        $usedRam  = $totalRam - [math]::Round($os.FreePhysicalMemory / 1MB, 2)
        $ramPct   = [math]::Round(($usedRam / $totalRam) * 100, 1)
        $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
        $diskTotal = [math]::Round($disk.Size / 1GB, 1)
        $diskUsed  = $diskTotal - [math]::Round($disk.FreeSpace / 1GB, 1)
        $diskPct   = [math]::Round(($diskUsed / $diskTotal) * 100, 1)
        $CpuBar.Value = $cpu; $RamBar.Value = $ramPct; $DiskBar.Value = $diskPct
        $CpuLabel.Text = "CPU  ::  $cpu %"
        $RamLabel.Text = "RAM  ::  $usedRam / $totalRam GB  ($ramPct %)"
        $DiskLabel.Text = "DISK ::  $diskUsed / $diskTotal GB  ($diskPct %)"
    } catch {}
}
function Update-NetworkInfo {
    try {
        $adapter = Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null } | Select-Object -First 1
        $publicIp = try { (Invoke-RestMethod "https://api.ipify.org?format=json" -TimeoutSec 3).ip } catch { "N/A" }
        $info = "ADAPTER   ::  $($adapter.InterfaceAlias)`n"
        $info += "LOCAL IP  ::  $($adapter.IPv4Address.IPAddress)`n"
        $info += "GATEWAY   ::  $($adapter.IPv4DefaultGateway.NextHop)`n"
        $info += "DNS       ::  $($adapter.DNSServer.ServerAddresses -join ', ')`n"
        $info += "PUBLIC IP ::  $publicIp"
        $NetworkInfo.Text = $info
    } catch { $NetworkInfo.Text = "Network info unavailable" }
}
Update-SystemStats
Update-NetworkInfo

$statsTimer = New-Object System.Windows.Threading.DispatcherTimer
$statsTimer.Interval = [TimeSpan]::FromSeconds(3)
$statsTimer.Add_Tick({ Update-SystemStats })
$statsTimer.Start()

$RefreshStatsBtn.Add_Click({ Update-SystemStats; Update-NetworkInfo; $LogBox.AppendText("`n// Stats refreshed") })
$SpeedTestBtn.Add_Click({
    $LogBox.AppendText("`n// Pinging 8.8.8.8 ...")
    $result = Test-Connection -ComputerName "8.8.8.8" -Count 4 -EA SilentlyContinue
    if ($result) {
        $avg = ($result | Measure-Object -Property ResponseTime -Average).Average
        $LogBox.AppendText("`n// Avg ping: $([math]::Round($avg,1)) ms")
    } else { $LogBox.AppendText("`n// Ping failed") }
})
$FixWingetBtn.Add_Click({
    $LogBox.AppendText("`n// Fixing winget...")
    try {
        Start-Process winget -ArgumentList "source reset --force" -Wait -NoNewWindow
        Start-Process winget -ArgumentList "source update" -Wait -NoNewWindow
        $LogBox.AppendText("`n// Winget OK")
    } catch { $LogBox.AppendText("`n// Error: $($_.Exception.Message)") }
})

# Apps tab
$apps = Get-RemoteJson "config/apps.json"
if ($apps) {
    foreach ($category in $apps.PSObject.Properties) {
        $header = New-Object System.Windows.Controls.TextBlock
        $header.Text = $category.Name.ToUpper()
        $header.FontWeight = "Bold"
        $header.FontSize = 12
        $header.Margin = "0,12,0,6"
        $header.Foreground = "#00D9FF"
        $AppsPanel.Children.Add($header) | Out-Null
        foreach ($app in $category.Value) {
            $cb = New-Object System.Windows.Controls.CheckBox
            $cb.Content = $app.name
            $cb.Tag = $app.id
            $cb.Margin = "10,2,0,2"
            $cb.Foreground = "#CCCCCC"
            $AppsPanel.Children.Add($cb) | Out-Null
        }
    }
}

$InstallBtn.Add_Click({
    $sel = @()
    foreach ($c in $AppsPanel.Children) { if ($c -is [System.Windows.Controls.CheckBox] -and $c.IsChecked) { $sel += $c.Tag } }
    if ($sel.Count -eq 0) { [System.Windows.MessageBox]::Show("No apps selected.", "SanjulaOS", "OK", "Information"); return }
    $LogBox.AppendText("`n// Installing $($sel.Count) app(s)...")
    foreach ($id in $sel) {
        $LogBox.AppendText("`n//   > $id")
        Start-Process winget -ArgumentList "install --id $id --silent --accept-source-agreements --accept-package-agreements" -Wait -NoNewWindow
    }
    $LogBox.AppendText("`n// Install complete")
})

$UninstallBtn.Add_Click({
    $sel = @()
    foreach ($c in $AppsPanel.Children) { if ($c -is [System.Windows.Controls.CheckBox] -and $c.IsChecked) { $sel += $c.Tag } }
    if ($sel.Count -eq 0) { return }
    $LogBox.AppendText("`n// Uninstalling $($sel.Count) app(s)...")
    foreach ($id in $sel) {
        $LogBox.AppendText("`n//   > removing $id")
        Start-Process winget -ArgumentList "uninstall --id $id --silent" -Wait -NoNewWindow
    }
    $LogBox.AppendText("`n// Done")
})

# === TWEAKS WITH INDIVIDUAL APPLY/REVERT ===
$tweakActionStyle = $window.FindResource("TweakActionBtn")
$tweaks = Get-RemoteJson "config/tweaks.json"
$global:AllTweakIds = @()
if ($tweaks) {
    foreach ($cat in $tweaks.PSObject.Properties) {
        $header = New-Object System.Windows.Controls.TextBlock
        $header.Text = $cat.Name.ToUpper()
        $header.FontWeight = "Bold"
        $header.FontSize = 12
        $header.Margin = "0,12,0,6"
        $header.Foreground = "#00D9FF"
        $TweaksPanel.Children.Add($header) | Out-Null

        foreach ($t in $cat.Value) {
            $global:AllTweakIds += $t.id
            $row = New-Object System.Windows.Controls.Grid
            $row.Margin = "8,3,0,3"
            $col1 = New-Object System.Windows.Controls.ColumnDefinition; $col1.Width = "*"
            $col2 = New-Object System.Windows.Controls.ColumnDefinition; $col2.Width = "Auto"
            $col3 = New-Object System.Windows.Controls.ColumnDefinition; $col3.Width = "Auto"
            $row.ColumnDefinitions.Add($col1) | Out-Null
            $row.ColumnDefinitions.Add($col2) | Out-Null
            $row.ColumnDefinitions.Add($col3) | Out-Null

            $label = New-Object System.Windows.Controls.TextBlock
            $label.Text = $t.name
            $label.Foreground = "#CCCCCC"
            $label.VerticalAlignment = "Center"
            $label.FontSize = 12
            $label.ToolTip = $t.desc
            [System.Windows.Controls.Grid]::SetColumn($label, 0)
            $row.Children.Add($label) | Out-Null

            $applyBtn = New-Object System.Windows.Controls.Button
            $applyBtn.Content = "APPLY"
            $applyBtn.Style = $tweakActionStyle
            $applyBtn.Tag = $t.id
            $applyBtn.ToolTip = $t.desc
            $applyBtn.Add_Click({
                param($s,$e)
                $LogBox.AppendText("`n// APPLY $($s.Tag)")
                try {
                    $r = Invoke-Tweak -Name $s.Tag -Action Apply
                    $LogBox.AppendText("  -> $r")
                } catch { $LogBox.AppendText("  -> ERROR: $($_.Exception.Message)") }
            }.GetNewClosure())
            [System.Windows.Controls.Grid]::SetColumn($applyBtn, 1)
            $row.Children.Add($applyBtn) | Out-Null

            $revertBtn = New-Object System.Windows.Controls.Button
            $revertBtn.Content = "REVERT"
            $revertBtn.Style = $tweakActionStyle
            $revertBtn.Tag = $t.id
            $revertBtn.ToolTip = "Restore default for: " + $t.name
            $revertBtn.Add_Click({
                param($s,$e)
                $LogBox.AppendText("`n// REVERT $($s.Tag)")
                try {
                    $r = Invoke-Tweak -Name $s.Tag -Action Revert
                    $LogBox.AppendText("  -> $r")
                } catch { $LogBox.AppendText("  -> ERROR: $($_.Exception.Message)") }
            }.GetNewClosure())
            [System.Windows.Controls.Grid]::SetColumn($revertBtn, 2)
            $row.Children.Add($revertBtn) | Out-Null

            $TweaksPanel.Children.Add($row) | Out-Null
        }
    }
}

$ApplyAllSafeBtn.Add_Click({
    if ([System.Windows.MessageBox]::Show("Apply ALL safe tweaks ($($global:AllTweakIds.Count) total)?", "Confirm", "YesNo", "Question") -ne "Yes") { return }
    $LogBox.AppendText("`n// APPLY ALL ($($global:AllTweakIds.Count) tweaks)...")
    foreach ($id in $global:AllTweakIds) {
        try { $r = Invoke-Tweak -Name $id -Action Apply; $LogBox.AppendText("`n//   [OK] $id -> $r") }
        catch { $LogBox.AppendText("`n//   [ERR] $id") }
    }
    $LogBox.AppendText("`n// ALL DONE")
})

$RevertAllBtn.Add_Click({
    if ([System.Windows.MessageBox]::Show("Revert ALL tweaks to Windows defaults?", "Confirm", "YesNo", "Question") -ne "Yes") { return }
    $LogBox.AppendText("`n// REVERT ALL ($($global:AllTweakIds.Count) tweaks)...")
    foreach ($id in $global:AllTweakIds) {
        try { $r = Invoke-Tweak -Name $id -Action Revert; $LogBox.AppendText("`n//   [OK] $id -> $r") }
        catch { $LogBox.AppendText("`n//   [ERR] $id") }
    }
    $LogBox.AppendText("`n// ALL REVERTED")
})

# === TOOLS / BRICKS ===
$brickStyle = $window.FindResource("BrickBtn")
$riskyStyle = $window.FindResource("RiskyBrickBtn")
$customs = Get-RemoteJson "config/custom.json"
if ($customs) {
    foreach ($cat in $customs.PSObject.Properties) {
        $isRiskyCat = $cat.Name -match "RISK"
        $header = New-Object System.Windows.Controls.TextBlock
        $header.Text = $cat.Name.ToUpper()
        $header.FontWeight = "Bold"
        $header.FontSize = 12
        $header.Margin = "5,10,0,5"
        $header.Foreground = if ($isRiskyCat) { "#FF6666" } else { "#00D9FF" }
        $CustomPanel.Children.Add($header) | Out-Null

        $wrap = New-Object System.Windows.Controls.WrapPanel
        $wrap.Orientation = "Horizontal"
        foreach ($item in $cat.Value) {
            $btn = New-Object System.Windows.Controls.Button
            $tb = New-Object System.Windows.Controls.TextBlock
            $tb.Text = $item.name.ToUpper()
            $tb.TextAlignment = "Center"
            $tb.TextWrapping = "Wrap"
            $tb.FontSize = 10
            $tb.FontWeight = "SemiBold"
            $btn.Content = $tb
            $btn.Tag = $item.script
            $btn.Style = if ($item.risky) { $riskyStyle } else { $brickStyle }
            if ($item.desc) { $btn.ToolTip = $item.desc }
            $btn.Add_Click({
                param($s,$e)
                $LogBox.AppendText("`n// Running: $($s.Content.Text)")
                Invoke-RemoteScript "scripts/$($s.Tag)"
            }.GetNewClosure())
            $wrap.Children.Add($btn) | Out-Null
        }
        $CustomPanel.Children.Add($wrap) | Out-Null
    }
}

$window.Add_Closed({ $timer.Stop(); $statsTimer.Stop() })
$window.ShowDialog() | Out-Null
