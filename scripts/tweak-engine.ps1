# SanjulaOS Tweak Engine
# All tweaks have Apply and Revert functions
# Called as: . tweak-engine.ps1; Invoke-Tweak -Name "tweak-id" -Action Apply|Revert

function Invoke-Tweak {
    param(
        [string]$Name,
        [ValidateSet("Apply","Revert")][string]$Action
    )
    switch ($Name) {

        # ===== PRIVACY =====
        "telemetry" {
            if ($Action -eq "Apply") {
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0 -Force -ErrorAction SilentlyContinue
                Get-Service DiagTrack -EA SilentlyContinue | Stop-Service -Force -EA SilentlyContinue
                Get-Service DiagTrack -EA SilentlyContinue | Set-Service -StartupType Disabled -EA SilentlyContinue
                "Telemetry disabled"
            } else {
                Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -EA SilentlyContinue
                Get-Service DiagTrack -EA SilentlyContinue | Set-Service -StartupType Automatic -EA SilentlyContinue
                Get-Service DiagTrack -EA SilentlyContinue | Start-Service -EA SilentlyContinue
                "Telemetry restored"
            }
        }
        "advertising-id" {
            $p = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
            if ($Action -eq "Apply") { Set-ItemProperty $p "Enabled" 0 -Type DWord -Force; "Advertising ID disabled" }
            else { Set-ItemProperty $p "Enabled" 1 -Type DWord -Force; "Advertising ID restored" }
        }
        "activity-history" {
            $p = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
            if ($Action -eq "Apply") {
                New-Item $p -Force | Out-Null
                Set-ItemProperty $p "PublishUserActivities" 0 -Type DWord -Force
                Set-ItemProperty $p "UploadUserActivities" 0 -Type DWord -Force
                "Activity history disabled"
            } else {
                Remove-ItemProperty $p "PublishUserActivities" -EA SilentlyContinue
                Remove-ItemProperty $p "UploadUserActivities" -EA SilentlyContinue
                "Activity history restored"
            }
        }
        "location-tracking" {
            $p = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
            if ($Action -eq "Apply") { Set-ItemProperty $p "SensorPermissionState" 0 -Type DWord -Force; "Location tracking disabled" }
            else { Set-ItemProperty $p "SensorPermissionState" 1 -Type DWord -Force; "Location tracking restored" }
        }
        "feedback-requests" {
            $p = "HKCU:\SOFTWARE\Microsoft\Siuf\Rules"
            if ($Action -eq "Apply") {
                New-Item $p -Force | Out-Null
                Set-ItemProperty $p "NumberOfSIUFInPeriod" 0 -Type DWord -Force
                "Feedback requests disabled"
            } else {
                Remove-ItemProperty $p "NumberOfSIUFInPeriod" -EA SilentlyContinue
                "Feedback requests restored"
            }
        }

        # ===== UI =====
        "dark-mode" {
            $p = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
            if ($Action -eq "Apply") {
                Set-ItemProperty $p "AppsUseLightTheme" 0 -Force
                Set-ItemProperty $p "SystemUsesLightTheme" 0 -Force
                "Dark mode enabled"
            } else {
                Set-ItemProperty $p "AppsUseLightTheme" 1 -Force
                Set-ItemProperty $p "SystemUsesLightTheme" 1 -Force
                "Light mode enabled"
            }
        }
        "show-extensions" {
            $p = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
            if ($Action -eq "Apply") { Set-ItemProperty $p "HideFileExt" 0 -Force; "File extensions visible" }
            else { Set-ItemProperty $p "HideFileExt" 1 -Force; "File extensions hidden" }
        }
        "show-hidden" {
            $p = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
            if ($Action -eq "Apply") { Set-ItemProperty $p "Hidden" 1 -Force; "Hidden files visible" }
            else { Set-ItemProperty $p "Hidden" 2 -Force; "Hidden files hidden" }
        }
        "classic-context-menu" {
            $p = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
            if ($Action -eq "Apply") {
                New-Item $p -Force | Out-Null
                Set-ItemProperty $p "(Default)" "" -Force
                "Classic right-click menu enabled"
            } else {
                Remove-Item ($p -replace "\\InprocServer32$","") -Recurse -Force -EA SilentlyContinue
                "Modern Win11 context menu restored"
            }
        }
        "taskbar-align-left" {
            $p = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
            if ($Action -eq "Apply") { Set-ItemProperty $p "TaskbarAl" 0 -Type DWord -Force; "Taskbar aligned left" }
            else { Set-ItemProperty $p "TaskbarAl" 1 -Type DWord -Force; "Taskbar centered" }
        }
        "transparency" {
            $p = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
            if ($Action -eq "Apply") { Set-ItemProperty $p "EnableTransparency" 0 -Type DWord -Force; "Transparency disabled" }
            else { Set-ItemProperty $p "EnableTransparency" 1 -Type DWord -Force; "Transparency enabled" }
        }
        "taskbar-animations" {
            $p = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
            if ($Action -eq "Apply") { Set-ItemProperty $p "TaskbarAnimations" 0 -Type DWord -Force; "Taskbar animations disabled" }
            else { Set-ItemProperty $p "TaskbarAnimations" 1 -Type DWord -Force; "Taskbar animations enabled" }
        }

        # ===== SEARCH/CORTANA =====
        "cortana" {
            $p = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
            if ($Action -eq "Apply") {
                New-Item $p -Force | Out-Null
                Set-ItemProperty $p "AllowCortana" 0 -Type DWord -Force
                "Cortana disabled"
            } else {
                Remove-ItemProperty $p "AllowCortana" -EA SilentlyContinue
                "Cortana restored"
            }
        }
        "bing-search" {
            $p = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
            if ($Action -eq "Apply") {
                New-Item $p -Force | Out-Null
                Set-ItemProperty $p "DisableSearchBoxSuggestions" 1 -Type DWord -Force
                "Bing search disabled in Start Menu"
            } else {
                Remove-ItemProperty $p "DisableSearchBoxSuggestions" -EA SilentlyContinue
                "Bing search restored"
            }
        }
        "web-search" {
            $p = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"
            if ($Action -eq "Apply") { Set-ItemProperty $p "BingSearchEnabled" 0 -Type DWord -Force; "Web search disabled" }
            else { Set-ItemProperty $p "BingSearchEnabled" 1 -Type DWord -Force; "Web search restored" }
        }

        # ===== PERFORMANCE =====
        "visual-effects-best-performance" {
            $p1 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
            if ($Action -eq "Apply") { Set-ItemProperty $p1 "VisualFXSetting" 2 -Type DWord -Force; "Set to Best Performance" }
            else { Set-ItemProperty $p1 "VisualFXSetting" 0 -Type DWord -Force; "Restored to default" }
        }
        "mouse-acceleration" {
            if ($Action -eq "Apply") {
                Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseSpeed" "0" -Force
                Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseThreshold1" "0" -Force
                Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseThreshold2" "0" -Force
                "Mouse acceleration disabled"
            } else {
                Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseSpeed" "1" -Force
                Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseThreshold1" "6" -Force
                Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseThreshold2" "10" -Force
                "Mouse acceleration restored"
            }
        }
        "game-bar" {
            $p1 = "HKCU:\Software\Microsoft\GameBar"
            $p2 = "HKCU:\System\GameConfigStore"
            if ($Action -eq "Apply") {
                Set-ItemProperty $p1 "AutoGameModeEnabled" 0 -Type DWord -Force -EA SilentlyContinue
                Set-ItemProperty $p2 "GameDVR_Enabled" 0 -Type DWord -Force -EA SilentlyContinue
                "Game Bar disabled"
            } else {
                Set-ItemProperty $p1 "AutoGameModeEnabled" 1 -Type DWord -Force -EA SilentlyContinue
                Set-ItemProperty $p2 "GameDVR_Enabled" 1 -Type DWord -Force -EA SilentlyContinue
                "Game Bar restored"
            }
        }
        "gpu-hw-scheduling" {
            $p = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
            if ($Action -eq "Apply") { Set-ItemProperty $p "HwSchMode" 2 -Type DWord -Force; "GPU HW scheduling enabled (reboot)" }
            else { Set-ItemProperty $p "HwSchMode" 1 -Type DWord -Force; "GPU HW scheduling disabled (reboot)" }
        }
        "fast-startup" {
            $p = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
            if ($Action -eq "Apply") { Set-ItemProperty $p "HiberbootEnabled" 0 -Type DWord -Force; "Fast Startup disabled" }
            else { Set-ItemProperty $p "HiberbootEnabled" 1 -Type DWord -Force; "Fast Startup enabled" }
        }

        # ===== UPDATES =====
        "auto-restart-updates" {
            $p = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
            if ($Action -eq "Apply") {
                New-Item $p -Force | Out-Null
                Set-ItemProperty $p "NoAutoRebootWithLoggedOnUsers" 1 -Type DWord -Force
                "Auto restart for updates disabled"
            } else {
                Remove-ItemProperty $p "NoAutoRebootWithLoggedOnUsers" -EA SilentlyContinue
                "Auto restart restored"
            }
        }

        # ===== EXPLORER =====
        "explorer-launch-this-pc" {
            $p = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
            if ($Action -eq "Apply") { Set-ItemProperty $p "LaunchTo" 1 -Type DWord -Force; "Explorer opens to This PC" }
            else { Set-ItemProperty $p "LaunchTo" 2 -Type DWord -Force; "Explorer opens to Quick Access" }
        }
        "explorer-no-recent" {
            $p = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
            if ($Action -eq "Apply") {
                Set-ItemProperty $p "ShowRecent" 0 -Type DWord -Force
                Set-ItemProperty $p "ShowFrequent" 0 -Type DWord -Force
                "Recent files hidden in Explorer"
            } else {
                Set-ItemProperty $p "ShowRecent" 1 -Type DWord -Force
                Set-ItemProperty $p "ShowFrequent" 1 -Type DWord -Force
                "Recent files visible in Explorer"
            }
        }

        # ===== SAFETY/ACCESSIBILITY =====
        "sticky-keys" {
            if ($Action -eq "Apply") {
                Set-ItemProperty "HKCU:\Control Panel\Accessibility\StickyKeys" "Flags" "506" -Force
                Set-ItemProperty "HKCU:\Control Panel\Accessibility\Keyboard Response" "Flags" "122" -Force
                Set-ItemProperty "HKCU:\Control Panel\Accessibility\ToggleKeys" "Flags" "58" -Force
                "Sticky/filter/toggle keys disabled"
            } else {
                Set-ItemProperty "HKCU:\Control Panel\Accessibility\StickyKeys" "Flags" "510" -Force
                Set-ItemProperty "HKCU:\Control Panel\Accessibility\Keyboard Response" "Flags" "126" -Force
                Set-ItemProperty "HKCU:\Control Panel\Accessibility\ToggleKeys" "Flags" "62" -Force
                "Accessibility prompts restored"
            }
        }

        # ===== NETWORK =====
        "network-discovery" {
            if ($Action -eq "Apply") {
                netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes | Out-Null
                "Network discovery enabled"
            } else {
                netsh advfirewall firewall set rule group="Network Discovery" new enable=No | Out-Null
                "Network discovery disabled"
            }
        }
        "ipv6" {
            if ($Action -eq "Apply") {
                Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" "DisabledComponents" 0xff -Type DWord -Force
                "IPv6 disabled (reboot)"
            } else {
                Remove-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" "DisabledComponents" -EA SilentlyContinue
                "IPv6 restored (reboot)"
            }
        }

        # ===== EDGE/ONEDRIVE =====
        "edge-startup-boost" {
            $p = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
            if ($Action -eq "Apply") {
                New-Item $p -Force | Out-Null
                Set-ItemProperty $p "StartupBoostEnabled" 0 -Type DWord -Force
                Set-ItemProperty $p "BackgroundModeEnabled" 0 -Type DWord -Force
                "Edge startup boost disabled"
            } else {
                Remove-ItemProperty $p "StartupBoostEnabled" -EA SilentlyContinue
                Remove-ItemProperty $p "BackgroundModeEnabled" -EA SilentlyContinue
                "Edge startup boost restored"
            }
        }

        # ===== POWER =====
        "ultimate-performance" {
            if ($Action -eq "Apply") {
                powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
                "Ultimate Performance plan added"
            } else {
                $p = (powercfg -list | Select-String "Ultimate Performance" | ForEach-Object { ($_ -split "\s+")[3] })
                if ($p) { powercfg -delete $p | Out-Null }
                "Ultimate Performance plan removed"
            }
        }
        "hibernate" {
            if ($Action -eq "Apply") { powercfg /hibernate off | Out-Null; "Hibernate disabled" }
            else { powercfg /hibernate on | Out-Null; "Hibernate enabled" }
        }

        default { "Unknown tweak: $Name" }
    }
}
