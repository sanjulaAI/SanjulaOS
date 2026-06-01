@echo off
:: ================================================================
::  GODMODE MERGED 2026 - ALL-IN-ONE
::  Combines:
::    - GODMODE ULTIMATE 2026 (sequential mode)
::    - GOD MODE ULTIMATE (Win 10/11)
::    - Nuclear Process Killer v6
::    - Windows Permanent Debloater
::    - Exm Premium Tweaks (BIOS/CPU/GPU/Power registry)
::    - MEGA ULTIMATE BEAST (15 advanced tweak categories)
::    - PUBG Mobile Network Optimizer (Sri Lanka / Dialog 4G)
::    - Anti-Stutter Fix
::    - auto_bios.bat (SCEWIN AMD + Intel - HIGH RISK)
::    - Mic-allow registry fixes
::
::  Each section asks Y/N. N skips to the next.
::  Run as Administrator.
:: ================================================================
title GODMODE MERGED 2026 - All-in-One
color 0A
setlocal EnableDelayedExpansion
cd /d "%~dp0"
chcp 65001 >nul 2>&1

:: ============================================================
::  ADMIN CHECK
:: ============================================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ============================================================
    echo        ADMINISTRATOR PRIVILEGES REQUIRED
    echo ============================================================
    echo Right-click this file and choose "Run as administrator".
    pause
    exit /b 1
)

:: ============================================================
::  OPTIONAL BACKUP (mimics Nuclear Killer behavior)
:: ============================================================
if not exist "C:\GodModeBackup" mkdir "C:\GodModeBackup" >nul 2>&1
reg export "HKLM\SYSTEM\CurrentControlSet\Services" "C:\GodModeBackup\services_backup.reg" /y >nul 2>&1
reg export "HKLM\SOFTWARE\Policies" "C:\GodModeBackup\policies_backup.reg" /y >nul 2>&1
copy "%SystemRoot%\System32\drivers\etc\hosts" "C:\GodModeBackup\hosts_backup.txt" >nul 2>&1
set "LOGFILE=C:\GodModeBackup\godmode_merged.log"
echo [%date% %time%] === GODMODE MERGED STARTED === > "%LOGFILE%"

cls
echo ============================================================
echo     GODMODE MERGED 2026 - ALL-IN-ONE
echo ============================================================
echo.
echo  Y/N before EACH section. N skips to the next.
echo.
echo   1.  Initial setup + UAC off + system restore knobs (Exm)
echo   2.  Performance Registry / BCD / Power (GODMODE+Exm)
echo   3.  VBS / HVCI / Memory Integrity / Spectre mitigations off
echo   4.  Bloat process killer
echo   5.  Remove Edge / OneDrive / Defender / Store
echo   6.  Remove Paint / WMP / Print / Bluetooth
echo   7.  Disable AI - Recall / Copilot / AI Fabric (24H2/25H2)
echo   8.  Disable 100+ non-essential services
echo   9.  Destroy telemetry / tracking / ads / spotlight
echo  10.  Kill Cortana / Search web / Widgets / SmartAppControl
echo  11.  Disable Windows Update permanently
echo  12.  Background apps + startup cleanup
echo  13.  Delete bloat scheduled tasks
echo  14.  Remove AppX bloat (200+ apps, all users, no reinstall)
echo  15.  Mouse + keyboard latency tweaks
echo  16.  Network adapter + latency optimization
echo  17.  PUBG / Dialog 4G network optimizer (Sri Lanka)
echo  18.  Mic-allow registry fixes
echo  19.  Performance tweaks (CPU/GPU/NTFS/Memory/UI)
echo  20.  Force MSI Mode on GPU + reduce DPC latency
echo  21.  Force Game Mode ON + disable Fullscreen Optimizations
echo  22.  MEGA BEAST - 15 advanced tweak categories
echo  23.  Anti-stutter fix (Gameloop/PUBG specific)
echo  24.  Cleanup temp / prefetch / shader cache / DNS
echo  25.  Group Policy lockdowns (debloater)
echo  26.  BIOS FLASH via SCEWIN_64 (auto_bios) - HIGH RISK
echo.
echo  WARNINGS (you accepted these):
echo   - UAC disabled
echo   - Defender + Windows Update permanently off
echo   - Spectre/Meltdown mitigations off
echo   - Memory Integrity off (anti-cheat may break)
echo   - BIOS flash can brick motherboard
echo.
choice /c YN /n /m "Begin? [Y/N]: "
if errorlevel 2 exit /b 0


:: ============================================================
::  SECTION 1 - INITIAL SETUP + UAC OFF + RESTORE KNOBS (EXM)
:: ============================================================
:S01
echo.
echo ============================================================
echo  [1/26] INITIAL SETUP + UAC OFF + SYSTEM RESTORE KNOBS
echo ============================================================
choice /c YN /n /m "Run section 1? [Y/N]: "
if errorlevel 2 goto :S02

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\SystemRestore" /v "RPSessionInterval" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\SystemRestore" /v "DisableConfig" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul 2>&1
powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\' >nul 2>&1
:: UAC off (you accepted the risk)
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d 1 /f >nul 2>&1

:: Exm "BIOS" registry tweaks (VxD - legacy, no effect on modern Win but kept as requested)
reg add "HKLM\System\CurrentControlSet\Services\VxD\BIOS" /v "CPUPriority" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\VxD\BIOS" /v "FastDRAM"    /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\VxD\BIOS" /v "AGPConcur"   /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\VxD\BIOS" /v "PCIConcur"   /t REG_DWORD /d 1 /f >nul 2>&1
echo [OK] Section 1 complete.


:: ============================================================
::  SECTION 2 - PERFORMANCE REGISTRY / BCD / POWER
:: ============================================================
:S02
echo.
echo ============================================================
echo  [2/26] PERFORMANCE REGISTRY / BCD / POWER
echo ============================================================
choice /c YN /n /m "Run section 2? [Y/N]: "
if errorlevel 2 goto :S03

:: BCD tweaks (full set from both scripts)
bcdedit /set tscsyncpolicy legacy >nul 2>&1
bcdedit /set hypervisorlaunchtype off >nul 2>&1
bcdedit /set linearaddress57 OptOut >nul 2>&1
bcdedit /set increaseuserva 268435328 >nul 2>&1
bcdedit /set isolatedcontext No >nul 2>&1
bcdedit /set allowedinmemorysettings 0x0 >nul 2>&1
bcdedit /set vsmlaunchtype Off >nul 2>&1
bcdedit /set vm No >nul 2>&1
bcdedit /set x2apicpolicy Enable >nul 2>&1
bcdedit /set uselegacyapicmode No >nul 2>&1
bcdedit /set configaccesspolicy Default >nul 2>&1
bcdedit /set MSI Default >nul 2>&1
bcdedit /set usephysicaldestination No >nul 2>&1
bcdedit /set usefirmwarepcisettings No >nul 2>&1
bcdedit /set "{current}" numproc %NUMBER_OF_PROCESSORS% >nul 2>&1
bcdedit /set "{current}" useplatformclock No >nul 2>&1
bcdedit /set "{current}" useplatformtick No >nul 2>&1
bcdedit /set "{current}" disabledynamictick Yes >nul 2>&1
bcdedit /set "{current}" allowedinmemorysettings 0x0 >nul 2>&1
bcdedit /deletevalue useplatformclock >nul 2>&1

:: Disable Intel/AMD PPM drivers
reg add "HKLM\SYSTEM\CurrentControlSet\Services\IntelPPM" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AmdPPM"   /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1

:: Power: max performance
powercfg /setacvalueindex scheme_current SUB_PROCESSOR SYSCOOLPOL 1 >nul 2>&1
powercfg /setdcvalueindex scheme_current SUB_PROCESSOR SYSCOOLPOL 1 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor PROCTHROTTLEMAX 100 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor PROCTHROTTLEMIN 50 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor CPMINCORES 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor CPMAXCORES 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor CPCONCURRENCY 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor THROTTLING 0 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor IDLEPROMOTE 98 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor IDLEDEMOTE 98 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor IDLECHECK 20000 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor IDLESCALING 1 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor IDLEDISABLE 1 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor PERFEPP 0 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor PERFBOOSTMODE 1 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor PERFBOOSTPOL 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_none DEVICEIDLE 0 >nul 2>&1
powercfg -setacvalueindex scheme_current SUB_SLEEP AWAYMODE 0 >nul 2>&1
powercfg -setacvalueindex scheme_current SUB_SLEEP ALLOWSTANDBY 0 >nul 2>&1
powercfg -setacvalueindex scheme_current SUB_SLEEP HYBRIDSLEEP 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1

:: Power registry knobs
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1" /v "Attributes" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\06cadf0e-64ed-448a-8927-ce7bf90eb35d" /v "Attributes" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "Attributes" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\ea062031-0e34-4ff1-9b6d-eb1059334028" /v "Attributes" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisplayPowerSaving" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

:: Ultimate Performance plan
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
for /f "tokens=4" %%G in ('powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2^>nul') do (
    powercfg -setactive %%G >nul 2>&1
)
powercfg -change -monitor-timeout-ac 0 >nul 2>&1
powercfg -change -monitor-timeout-dc 0 >nul 2>&1
powercfg -change -standby-timeout-ac 0 >nul 2>&1
powercfg -change -standby-timeout-dc 0 >nul 2>&1
powercfg -change -disk-timeout-ac 0 >nul 2>&1
powercfg -change -disk-timeout-dc 0 >nul 2>&1
powercfg -change -hibernate-timeout-ac 0 >nul 2>&1
powercfg -h off >nul 2>&1

:: NVIDIA GPU tweaks (TDR + power-mizer)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDebugMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLimitCount" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLimitTime" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrTestMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "PlatformSupportMiracast" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PowerMizerEnable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PowerMizerLevel" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PowerMizerLevelAC" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PerfLevelSrc" /t REG_DWORD /d 8738 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableWriteCombining" /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global" /v "EnableRID66610" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global" /v "EnableRID64640" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global" /v "EnableRID44231" /t REG_DWORD /d 0 /f >nul 2>&1
for %%T in (
    "NvTmRepCrashReport1B2FE1952-0186-46C3-BAEC-A80AA35AC5B8"
    "NvTmRepCrashReport2B2FE1952-0186-46C3-BAEC-A80AA35AC5B8"
    "NvTmRepCrashReport3B2FE1952-0186-46C3-BAEC-A80AA35AC5B8"
    "NvTmRepCrashReport4B2FE1952-0186-46C3-BAEC-A80AA35AC5B8"
    "NvDriverUpdateCheckDailyB2FE1952-0186-46C3-BAEC-A80AA35AC5B8"
    "NVIDIA GeForce Experience SelfUpdateB2FE1952-0186-46C3-BAEC-A80AA35AC5B8"
    "NvTmMonB2FE1952-0186-46C3-BAEC-A80AA35AC5B8"
) do schtasks /change /disable /tn %%T >nul 2>&1
echo [OK] Section 2 complete.


:: ============================================================
::  SECTION 3 - VBS / HVCI / MEMORY INTEGRITY / SPECTRE
:: ============================================================
:S03
echo.
echo ============================================================
echo  [3/26] DISABLE VBS / HVCI / MEMORY INTEGRITY / SPECTRE
echo ============================================================
choice /c YN /n /m "Run section 3? [Y/N]: "
if errorlevel 2 goto :S04

reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "WasEnabledBy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "RequirePlatformSecurityFeatures" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "Locked" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "RequirePlatformSecurityFeatures" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "LsaCfgFlags" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "LsaCfgFlags" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\HvHost" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmcompute" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmms" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v "DisableExternalDMAUnderLock" /t REG_DWORD /d 0 /f >nul 2>&1
:: Spectre/Meltdown off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d 1 /f >nul 2>&1
echo [OK] Section 3 complete.


:: ============================================================
::  SECTION 4 - KILL BLOAT PROCESSES
:: ============================================================
:S04
echo.
echo ============================================================
echo  [4/26] KILLING BLOAT PROCESSES
echo ============================================================
choice /c YN /n /m "Run section 4? [Y/N]: "
if errorlevel 2 goto :S05

for %%P in (
    OneDrive.exe Teams.exe Spotify.exe Discord.exe Slack.exe Zoom.exe
    cortana.exe searchapp.exe widgetservice.exe newsandinterests.exe
    copilot.exe Copilot.exe WebExperience.exe YourPhone.exe PhoneExperienceHost.exe
    msedge.exe MicrosoftEdge.exe MicrosoftEdgeUpdate.exe edgeupdatem.exe msedgewebview2.exe
    ZuneMusic.exe ZuneVideo.exe XboxApp.exe XboxGameCallableUI.exe
    XboxGamingOverlay.exe XboxIdentityProvider.exe XboxSpeechToTextOverlay.exe
    GameBar.exe GameBarFTServer.exe GameBarPresenceWriter.exe
    Microsoft.Photos.exe Microsoft.Windows.Photos.exe SettingSyncHost.exe
    SecurityHealthSystray.exe SgrmBroker.exe smartscreen.exe
    MsMpEng.exe NisSrv.exe mspaint.exe wmplayer.exe wmpnscfg.exe
    BTAGService.exe fsquirt.exe sihost.exe
    AIRecallService.exe AIFabric.exe RecallEngine.exe
    SearchUI.exe SearchApp.exe Widgets.exe RuntimeBroker.exe
) do taskkill /f /im %%P >nul 2>&1
echo [OK] Section 4 complete.


:: ============================================================
::  SECTION 5 - REMOVE EDGE / ONEDRIVE / DEFENDER / STORE
:: ============================================================
:S05
echo.
echo ============================================================
echo  [5/26] REMOVE EDGE / ONEDRIVE / DEFENDER / STORE
echo ============================================================
choice /c YN /n /m "Run section 5? [Y/N]: "
if errorlevel 2 goto :S06

:: --- EDGE ---
sc stop edgeupdate >nul 2>&1
sc stop edgeupdatem >nul 2>&1
sc stop MicrosoftEdgeElevationService >nul 2>&1
sc delete edgeupdate >nul 2>&1
sc delete edgeupdatem >nul 2>&1
sc delete MicrosoftEdgeElevationService >nul 2>&1
for /d %%d in ("%ProgramFiles(x86)%\Microsoft\Edge\Application\*") do (
    if exist "%%d\Installer\setup.exe" "%%d\Installer\setup.exe" --uninstall --force-uninstall --system-level >nul 2>&1
)
for /d %%d in ("%ProgramFiles%\Microsoft\Edge\Application\*") do (
    if exist "%%d\Installer\setup.exe" "%%d\Installer\setup.exe" --uninstall --force-uninstall --system-level >nul 2>&1
)
for /d %%d in ("%ProgramFiles(x86)%\Microsoft\EdgeWebView\Application\*") do (
    if exist "%%d\Installer\setup.exe" "%%d\Installer\setup.exe" --uninstall --msedgewebview --force-uninstall --system-level >nul 2>&1
)
takeown /f "%ProgramFiles(x86)%\Microsoft\Edge" /r /d y >nul 2>&1
icacls "%ProgramFiles(x86)%\Microsoft\Edge" /grant administrators:F /t >nul 2>&1
rmdir /s /q "%ProgramFiles(x86)%\Microsoft\Edge" >nul 2>&1
rmdir /s /q "%ProgramFiles%\Microsoft\Edge" >nul 2>&1
rmdir /s /q "%LocalAppData%\Microsoft\Edge" >nul 2>&1
rmdir /s /q "%ProgramData%\Microsoft\Edge" >nul 2>&1
rmdir /s /q "%LocalAppData%\Microsoft\EdgeUpdate" >nul 2>&1
rmdir /s /q "%ProgramData%\Microsoft\EdgeUpdate" >nul 2>&1
rmdir /s /q "%ProgramFiles(x86)%\Microsoft\EdgeUpdate" >nul 2>&1
rmdir /s /q "%ProgramFiles(x86)%\Microsoft\EdgeWebView" >nul 2>&1
rmdir /s /q "%ProgramFiles%\Microsoft\EdgeWebView" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MicrosoftEdge* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like '*MicrosoftEdge*' | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "InstallDefault" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "UpdateDefault" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "AutoUpdateCheckPeriodMinutes" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /v "Install{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}" /t REG_DWORD /d 0 /f >nul 2>&1
del /f /q "%PUBLIC%\Desktop\Microsoft Edge.lnk" >nul 2>&1
del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" >nul 2>&1
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" >nul 2>&1

:: --- ONEDRIVE ---
taskkill /f /im OneDrive.exe >nul 2>&1
if exist "%SystemRoot%\System32\OneDriveSetup.exe" "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall >nul 2>&1
if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall >nul 2>&1
rmdir /s /q "%UserProfile%\OneDrive" >nul 2>&1
rmdir /s /q "%LocalAppData%\Microsoft\OneDrive" >nul 2>&1
rmdir /s /q "%ProgramData%\Microsoft OneDrive" >nul 2>&1
reg delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1

:: --- DEFENDER ---
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "ForceUpdateFromMU" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration" /v "Notification_Suppress" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" /v "VerifiedAndReputablePolicyState" /t REG_DWORD /d 0 /f >nul 2>&1
for %%S in (WinDefend SecurityHealthService wscsvc WdNisSvc WdNisDrv Sense WdFilter WdBoot mpssvc) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
)
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /t REG_DWORD /d 1 /f >nul 2>&1

:: --- STORE ---
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *WindowsStore* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like '*WindowsStore*' | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *StorePurchaseApp* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableStoreApps" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul 2>&1
echo [OK] Section 5 complete.


:: ============================================================
::  SECTION 6 - REMOVE PAINT / WMP / PRINT / BLUETOOTH
:: ============================================================
:S06
echo.
echo ============================================================
echo  [6/26] REMOVE PAINT / WMP / PRINT / BLUETOOTH
echo ============================================================
choice /c YN /n /m "Run section 6? [Y/N]: "
if errorlevel 2 goto :S07

powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MSPaint* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Paint* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like '*Paint*' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1

dism /online /Disable-Feature /FeatureName:"WindowsMediaPlayer" /NoRestart >nul 2>&1
dism /online /Remove-Capability /CapabilityName:"Media.WindowsMediaPlayer~~~~0.0.12.0" /NoRestart >nul 2>&1
sc stop WMPNetworkSvc >nul 2>&1 & sc config WMPNetworkSvc start= disabled >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *ZuneMusic* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *ZuneVideo* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like '*Zune*' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1

sc stop Spooler >nul 2>&1 & sc config Spooler start= disabled >nul 2>&1
sc stop Fax >nul 2>&1 & sc config Fax start= disabled >nul 2>&1
dism /online /Disable-Feature /FeatureName:"Printing-PrintToPDFServices-Features" /NoRestart >nul 2>&1
dism /online /Disable-Feature /FeatureName:"Printing-XPSServices-Features" /NoRestart >nul 2>&1
dism /online /Remove-Capability /CapabilityName:"Print.Fax.Scan~~~~0.0.1.0" /NoRestart >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers" /v "DisableWebPnPDownload" /t REG_DWORD /d 1 /f >nul 2>&1

for %%S in (bthserv BTAGService BthAvctpSvc bthHFSrv) do (
    sc stop %%S >nul 2>&1 & sc config %%S start= disabled >nul 2>&1
)
dism /online /Disable-Feature /FeatureName:"Bluetooth" /NoRestart >nul 2>&1
echo [OK] Section 6 complete.


:: ============================================================
::  SECTION 7 - DISABLE AI (RECALL / COPILOT / AI FABRIC)
:: ============================================================
:S07
echo.
echo ============================================================
echo  [7/26] DISABLE AI - RECALL + COPILOT + AI FABRIC
echo ============================================================
choice /c YN /n /m "Run section 7? [Y/N]: "
if errorlevel 2 goto :S08

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "AllowRecallEnablement" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WindowsAI\DisableAIDataAnalysis" /v "value" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableClickToDo" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableImageCreator" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableCocreator" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableGenerativeFill" /t REG_DWORD /d 1 /f >nul 2>&1

for %%S in (
    AIRecallService
    "AI Fabric Service"
    AIFabricSvc
    InputInsights
    GenerativeAIInferenceSvc
    SharedRealitySvc
    PerceptionService
) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)
for %%A in (Copilot WindowsAI Recall MicrosoftCopilot AIRecall) do (
    powershell -NoProfile -Command "Get-AppxPackage -AllUsers *%%A* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
    powershell -NoProfile -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like '*%%A*' | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
)
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.549981C3F5F10* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like '*549981C3F5F10*' | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
echo [OK] Section 7 complete.


:: ============================================================
::  SECTION 8 - DISABLE NON-ESSENTIAL SERVICES
:: ============================================================
:S08
echo.
echo ============================================================
echo  [8/26] DISABLE 100+ NON-ESSENTIAL SERVICES
echo ============================================================
choice /c YN /n /m "Run section 8? [Y/N]: "
if errorlevel 2 goto :S09

for %%S in (
    DiagTrack dmwappushservice WerSvc PcaSvc WSearch SysMain
    XboxNetApiSvc XblAuthManager XblGameSave XboxGipSvc
    GamingServices GamingServicesNet MapsBroker lfsvc GeoSvc
    RemoteRegistry RemoteAccess SessionEnv TermService UmRdpService
    Fax RetailDemo WMPNetworkSvc SCardSvr ScDeviceEnum
    TabletInputService PhoneSvc icssvc
    WpnService WpnUserService HomeGroupListener HomeGroupProvider
    PeerDistSvc p2psvc p2pimsvc PNRPsvc PNRPAutoReg
    seclogon AJRouter CDPSvc CDPUserSvc
    sppsvc NcaSvc DusmSvc DsSvc
    diagnosticshub.standardcollector.service diagsvc DPS WdiServiceHost WdiSystemHost
    LicenseManager wisvc MessagingService PimIndexMaintenanceSvc
    UnistoreSvc UserDataSvc OneSyncSvc SharedAccess
    wcncsvc TlSsvc wercplsupport wmiApSrv
    PrintNotify wmphost perceptionsimulation
    TroubleshootingSvc
    stisvc WiaRpc StiSvc
    Browser
    defragsvc DcpSvc NcdAutoSetup
    WwanSvc dot3svc EapHost
    FDResPub SSDPSRV upnphost WinHttpAutoProxySvc
    WbioSrvc spectrum
    SensorDataService SensorService SensrSvc
    AppVClient SCPolicySvc RasAuto RasMan WarpJITSvc
    AarSvc CaptureService ConsentUxUserSvc CredentialEnrollmentManagerUserSvc
    DeviceAssociationBrokerSvc DevicePickerUserSvc DevicesFlowUserSvc
    DialogBlockingService DisplayEnhancementService
    EbmUserSvc NaturalAuthentication PrintWorkflowUserSvc
    UdkUserSvc UevAgentService PerfHost SEMgrSvc ClipSVC
    NPSMSvc CertPropSvc ShellHWDetection
) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)
echo [OK] Section 8 complete.


:: ============================================================
::  SECTION 9 - TELEMETRY / TRACKING / ADS / SPOTLIGHT
:: ============================================================
:S09
echo.
echo ============================================================
echo  [9/26] DESTROY TELEMETRY / TRACKING / ADS / SPOTLIGHT
echo ============================================================
choice /c YN /n /m "Run section 9? [Y/N]: "
if errorlevel 2 goto :S10

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitDiagnosticLogCollection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DisableOneSettingsDownloads" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DisableDiagnosticSettingsReset" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableCloudOptimizedContent" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableTailoredExperiencesWithDiagnosticData" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSpotlightCollectionOnDesktop" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSpotlightActions" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightOnActionCenter" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightOnSettings" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightWindowsWelcomeExperience" /t REG_DWORD /d 1 /f >nul 2>&1
for %%V in (SoftLandingEnabled SubscribedContentEnabled ContentDeliveryAllowed OemPreInstalledAppsEnabled PreInstalledAppsEnabled PreInstalledAppsEverEnabled SilentInstalledAppsEnabled SystemPaneSuggestionsEnabled RotatingLockScreenEnabled RotatingLockScreenOverlayEnabled RemediationRequired SubscribedContent-310093Enabled SubscribedContent-338387Enabled SubscribedContent-338388Enabled SubscribedContent-338389Enabled SubscribedContent-353694Enabled SubscribedContent-353696Enabled) do (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "%%V" /t REG_DWORD /d 0 /f >nul 2>&1
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "AllowInputPersonalization" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Speech" /v "AllowSpeechModelUpdate" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AllowUntriggeredNetworkTrafficOnSettingsPage" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "01" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\StorageSense" /v "AllowStorageSenseGlobal" /t REG_DWORD /d 0 /f >nul 2>&1
echo [OK] Section 9 complete.


:: ============================================================
::  SECTION 10 - CORTANA / SEARCH WEB / WIDGETS / SAC
:: ============================================================
:S10
echo.
echo ============================================================
echo  [10/26] CORTANA / WEB SEARCH / WIDGETS / SMART APP CONTROL
echo ============================================================
choice /c YN /n /m "Run section 10? [Y/N]: "
if errorlevel 2 goto :S11

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HidePeopleBar" /t REG_DWORD /d 1 /f >nul 2>&1

:: Smart App Control + reputation
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f >nul 2>&1
echo [OK] Section 10 complete.


:: ============================================================
::  SECTION 11 - DISABLE WINDOWS UPDATE PERMANENTLY
:: ============================================================
:S11
echo.
echo ============================================================
echo  [11/26] DISABLE WINDOWS UPDATE PERMANENTLY
echo ============================================================
choice /c YN /n /m "Run section 11? [Y/N]: "
if errorlevel 2 goto :S12

for %%S in (wuauserv BITS TrustedInstaller DoSvc Dosvc UsoSvc WaaSMedicSvc wlidsvc UpdateOrchestrator) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /t REG_SZ /d " " /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /t REG_SZ /d " " /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableDualScan" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" /v "Debugger" /t REG_SZ /d "%windir%\System32\taskkill.exe" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotificationUx.exe" /v "Debugger" /t REG_SZ /d "%windir%\System32\taskkill.exe" /f >nul 2>&1

findstr /c:"windowsupdate.microsoft.com" "%SystemRoot%\System32\drivers\etc\hosts" >nul 2>&1
if %errorlevel% neq 0 (
    >> "%SystemRoot%\System32\drivers\etc\hosts" echo 0.0.0.0 windowsupdate.microsoft.com
    >> "%SystemRoot%\System32\drivers\etc\hosts" echo 0.0.0.0 update.microsoft.com
    >> "%SystemRoot%\System32\drivers\etc\hosts" echo 0.0.0.0 download.windowsupdate.com
    >> "%SystemRoot%\System32\drivers\etc\hosts" echo 0.0.0.0 wustat.windows.com
    >> "%SystemRoot%\System32\drivers\etc\hosts" echo 0.0.0.0 ntservicepack.microsoft.com
    >> "%SystemRoot%\System32\drivers\etc\hosts" echo 0.0.0.0 stats.update.microsoft.com
)
echo [OK] Section 11 complete.


:: ============================================================
::  SECTION 12 - BACKGROUND APPS + STARTUP CLEANUP
:: ============================================================
:S12
echo.
echo ============================================================
echo  [12/26] BACKGROUND APPS + STARTUP CLEANUP
echo ============================================================
choice /c YN /n /m "Run section 12? [Y/N]: "
if errorlevel 2 goto :S13

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
for %%V in (LetAppsRunInBackground LetAppsAccessCamera LetAppsAccessLocation LetAppsAccessContacts LetAppsAccessCalendar LetAppsAccessCallHistory LetAppsAccessEmail LetAppsAccessMessaging LetAppsAccessNotifications LetAppsAccessRadios LetAppsSyncWithDevices LetAppsAccessAccountInfo) do (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "%%V" /t REG_DWORD /d 2 /f >nul 2>&1
)
:: NOTE: Mic-allow re-applied in section 18

reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /va /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /va /f >nul 2>&1
echo [OK] Section 12 complete.


:: ============================================================
::  SECTION 13 - DELETE BLOAT SCHEDULED TASKS
:: ============================================================
:S13
echo.
echo ============================================================
echo  [13/26] DELETE BLOAT SCHEDULED TASKS
echo ============================================================
choice /c YN /n /m "Run section 13? [Y/N]: "
if errorlevel 2 goto :S14

for %%T in (
    "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
    "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
    "\Microsoft\Windows\Application Experience\StartupAppTask"
    "\Microsoft\Windows\Application Experience\AitAgent"
    "\Microsoft\Windows\Application Experience\PcaPatchDbTask"
    "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
    "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
    "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
    "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
    "\Microsoft\Windows\Feedback\Siuf\DmClient"
    "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
    "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
    "\Microsoft\Windows\WindowsUpdate\Automatic App Update"
    "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
    "\Microsoft\Windows\WindowsUpdate\sih"
    "\Microsoft\Windows\WindowsUpdate\sihboot"
    "\Microsoft\Windows\Maps\MapsUpdateTask"
    "\Microsoft\Windows\Maps\MapsToastTask"
    "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
    "\Microsoft\Windows\Shell\FamilySafetyMonitor"
    "\Microsoft\Windows\Shell\FamilySafetyRefresh"
    "\Microsoft\Windows\License Manager\TempSignedLicenseExchange"
    "\Microsoft\Windows\Clip\License Validation"
    "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
    "\Microsoft\Windows\DiskFootprint\Diagnostics"
    "\Microsoft\Windows\FileHistory\File History (maintenance mode)"
    "\Microsoft\Windows\Speech\SpeechModelDownloadTask"
    "\Microsoft\Windows\UNP\RunUpdateNotificationMgr"
    "\Microsoft\Windows\Location\Notifications"
    "\Microsoft\Windows\Location\WindowsActionDialog"
    "\Microsoft\Windows\Diagnosis\Scheduled"
    "\Microsoft\Windows\MUI\LPRemove"
    "\Microsoft\Windows\NetTrace\GatherNetworkInfo"
    "\Microsoft\Windows\PI\Sqm-Tasks"
    "\Microsoft\Windows\WDI\ResolutionHost"
    "\Microsoft\Windows\PushToInstall\LoginCheck"
    "\Microsoft\Windows\PushToInstall\Registration"
    "\Microsoft\Windows\Management\Provisioning\Logon"
    "\Microsoft\Windows\SettingSync\BackupTask"
    "\Microsoft\Windows\SettingSync\NetworkStateChangeTask"
    "\Microsoft\Windows\USB\Usb-Notifications"
    "\Microsoft\Windows\Workplace Join\Automatic-Device-Join"
    "\Microsoft\XblGameSave\XblGameSaveTask"
    "\Microsoft\XblGameSave\XblGameSaveTaskLogon"
    "\Microsoft\Windows\HelloFace\FODCleanupTask"
    "\Microsoft\Windows\Autochk\Proxy"
    "\Microsoft\Windows\Defrag\ScheduledDefrag"
    "\Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser"
    "\Microsoft\Windows\WindowsAI\RecallSnapshotTask"
    "\Microsoft\Windows\WindowsAI\GenerativeRefreshTask"
) do (
    schtasks /Change /TN "%%~T" /Disable >nul 2>&1
    schtasks /Delete /TN "%%~T" /F >nul 2>&1
)
echo [OK] Section 13 complete.


:: ============================================================
::  SECTION 14 - REMOVE 200+ APPX BLOAT
:: ============================================================
:S14
echo.
echo ============================================================
echo  [14/26] REMOVE APPX BLOAT (ALL USERS, NO REINSTALL)
echo ============================================================
choice /c YN /n /m "Run section 14? [Y/N]: "
if errorlevel 2 goto :S15

set "APPX_BLOAT=3DBuilder 3DViewer ActiproSoftware AdobePhotoshopExpress HPJumpStart HPPCHardwareDiagnostics HPSmart HPSupportAssistant AmazonVideo Asphalt8 AirMeasure AmpliTube AOLSoftware BingWeather BingNews BingFinance BingSports BingTranslator Bubbles CandyCrush DiamondMine JewelMatch HiddenCity BubbleWitch3Saga MarchofEmpires DisneyPlus Duolingo eBay Facebook Netflix Twitter TikTok Instagram Pinterest LinkedIn Spotify Pandora Hulu SlingTV Vudu FoxSports ESPN NFL NBA MLB Fitbit FlurryTravel Keeper FeedbackHub GetHelp Getstarted MicrosoftOfficeHub MicrosoftSolitaireCollection MixedReality Office.OneNote OneConnect People Print3D SkypeApp StickyNotes Teams Todos Whiteboard WindowsAlarms WindowsCamera windowscommunicationsapps WindowsMaps WindowsSoundRecorder Xbox YourPhone Clipchamp PowerAutomateDesktop QuickAssist GamingApp Microsoft.Advertising.Xaml Microsoft.HEIFImageExtension Microsoft.Messaging Microsoft.Microsoft3DViewer Microsoft.OneConnect Microsoft.Wallet Microsoft.WebMediaExtensions Microsoft.WebpImageExtension Microsoft.Xbox.TCUI Microsoft.MixedReality.Portal Microsoft.Windows.Devices.Hardware Microsoft.Windows.HolographicFirstRun Microsoft.Windows.Phone Microsoft.WindowsFeedback Microsoft.WindowsReadingList MicrosoftTeams MicrosoftWindows.Client.WebExperience Family"
for %%A in (%APPX_BLOAT%) do (
    powershell -NoProfile -Command "Get-AppxPackage -AllUsers *%%A* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
    powershell -NoProfile -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like '*%%A*' | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
)
echo [OK] Section 14 complete.


:: ============================================================
::  SECTION 15 - MOUSE + KEYBOARD LATENCY
:: ============================================================
:S15
echo.
echo ============================================================
echo  [15/26] MOUSE + KEYBOARD LATENCY TWEAKS
echo ============================================================
choice /c YN /n /m "Run section 15? [Y/N]: "
if errorlevel 2 goto :S16

reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d 50 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d 50 /f >nul 2>&1
reg add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f >nul 2>&1
powercfg -setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg -setdcvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
echo [OK] Section 15 complete.


:: ============================================================
::  SECTION 16 - NETWORK ADAPTER + LATENCY
:: ============================================================
:S16
echo.
echo ============================================================
echo  [16/26] NETWORK ADAPTER + LATENCY OPTIMIZATION
echo ============================================================
choice /c YN /n /m "Run section 16? [Y/N]: "
if errorlevel 2 goto :S17

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d 30 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d 64 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDataRetransmissions" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d 65535 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d 65535 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxFreeTcbs" /t REG_DWORD /d 65535 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxHashTableSize" /t REG_DWORD /d 65535 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d 65534 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableTCPChimney" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableTCPA" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableRSS" /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Nagle on every interface
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces' -ErrorAction SilentlyContinue | ForEach-Object {" ^
  "  try { Set-ItemProperty -Path $_.PSPath -Name 'TcpAckFrequency' -Value 1 -Type DWord -ErrorAction SilentlyContinue } catch {};" ^
  "  try { Set-ItemProperty -Path $_.PSPath -Name 'TCPNoDelay' -Value 1 -Type DWord -ErrorAction SilentlyContinue } catch {};" ^
  "  try { Set-ItemProperty -Path $_.PSPath -Name 'TcpDelAckTicks' -Value 0 -Type DWord -ErrorAction SilentlyContinue } catch {};" ^
  "}" >nul 2>&1

netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global chimney=disabled >nul 2>&1
netsh int tcp set heuristics disabled >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set global initialRto=2000 >nul 2>&1
netsh int tcp set global nonsackrttresiliency=disabled >nul 2>&1
netsh int tcp set global rsc=disabled >nul 2>&1
netsh int tcp set global maxsynretransmissions=2 >nul 2>&1
netsh int tcp set supplemental Internet congestionprovider=ctcp >nul 2>&1

:: Network Disk I/O
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "IRPStackSize" /t REG_DWORD /d 20 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SizReqBuf" /t REG_DWORD /d 17424 /f >nul 2>&1

powershell -NoProfile -Command "Get-NetAdapter | ForEach-Object { try { Set-NetAdapterPowerManagement -Name $_.Name -AllowComputerToTurnOffDevice Disabled -ErrorAction SilentlyContinue } catch {} }" >nul 2>&1
echo [OK] Section 16 complete.


:: ============================================================
::  SECTION 17 - PUBG / DIALOG 4G NETWORK OPTIMIZER (SL)
:: ============================================================
:S17
echo.
echo ============================================================
echo  [17/26] PUBG MOBILE NETWORK OPTIMIZER (SRI LANKA)
echo ============================================================
echo  Resets Winsock + TCP/IP, renews IP, sets Cloudflare DNS.
echo  Close PUBG / GameLoop before continuing.
choice /c YN /n /m "Run section 17? [Y/N]: "
if errorlevel 2 goto :S18

ipconfig /flushdns >nul 2>&1
netsh winsock reset >nul 2>&1
netsh int ip reset >nul 2>&1
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
ipconfig /registerdns >nul 2>&1

netsh interface ip set dns name="Ethernet" static 1.1.1.1 primary >nul 2>&1
netsh interface ip add dns name="Ethernet" 1.0.0.1 index=2 >nul 2>&1
netsh interface ip set dns name="Wi-Fi" static 1.1.1.1 primary >nul 2>&1
netsh interface ip add dns name="Wi-Fi" 1.0.0.1 index=2 >nul 2>&1
:: Also bulk-set on every connected adapter
for /f "tokens=3*" %%a in ('netsh interface show interface ^| findstr /R "Connected"') do (
    netsh interface ipv4 set dns name="%%a %%b" static 1.1.1.1 primary >nul 2>&1
    netsh interface ipv4 add dns name="%%a %%b" 1.0.0.1 index=2 >nul 2>&1
    netsh interface ipv4 add dns name="%%a %%b" 8.8.8.8 index=3 >nul 2>&1
)

netsh int tcp set global chimney=enabled >nul 2>&1
netsh int tcp set global ecncapability=enabled >nul 2>&1
netsh int tcp set heuristics disabled >nul 2>&1
ipconfig /flushdns >nul 2>&1
echo [OK] Section 17 complete.


:: ============================================================
::  SECTION 18 - MIC-ALLOW REGISTRY FIXES
:: ============================================================
:S18
echo.
echo ============================================================
echo  [18/26] MIC-ALLOW REGISTRY FIXES
echo ============================================================
choice /c YN /n /m "Run section 18? [Y/N]: "
if errorlevel 2 goto :S19

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMicrophone" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1
echo [OK] Section 18 complete.


:: ============================================================
::  SECTION 19 - PERFORMANCE TWEAKS (CPU/GPU/NTFS/MEMORY/UI)
:: ============================================================
:S19
echo.
echo ============================================================
echo  [19/26] PERFORMANCE TWEAKS (CPU/GPU/NTFS/Memory/UI)
echo ============================================================
choice /c YN /n /m "Run section 19? [Y/N]: "
if errorlevel 2 goto :S20

:: Visual effects - performance + UI snappiness
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_DWORD /d 1000 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreen" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 983040 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargePageMinimum" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Ndu" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsMftZoneReservation" /t REG_DWORD /d 2 /f >nul 2>&1
fsutil behavior set disablelastaccess 1 >nul 2>&1
fsutil behavior set encryptpagingfile 0 >nul 2>&1
fsutil behavior set memoryusage 2 >nul 2>&1
fsutil behavior set mftzone 2 >nul 2>&1
fsutil behavior set DisableDeleteNotify 0 >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DirectX" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DirectX" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DirectX" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "LogEvent" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "SendAlert" /t REG_DWORD /d 0 /f >nul 2>&1

schtasks /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /Disable >nul 2>&1
echo [OK] Section 19 complete.


:: ============================================================
::  SECTION 20 - MSI MODE GPU + DPC LATENCY
:: ============================================================
:S20
echo.
echo ============================================================
echo  [20/26] FORCE MSI MODE ON GPU (reduces DPC latency)
echo ============================================================
choice /c YN /n /m "Run section 20? [Y/N]: "
if errorlevel 2 goto :S21

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$instances = Get-PnpDevice -ErrorAction SilentlyContinue | Where-Object { $_.InstanceId -like 'PCI\\*' -and $_.Class -in @('Display','Net') };" ^
  "foreach ($d in $instances) {" ^
  "  $base = 'HKLM:\\SYSTEM\\CurrentControlSet\\Enum\\' + $d.InstanceId + '\\Device Parameters\\Interrupt Management';" ^
  "  $msi  = Join-Path $base 'MessageSignaledInterruptProperties';" ^
  "  $aff  = Join-Path $base 'Affinity Policy';" ^
  "  try { New-Item -Path $msi -Force -ErrorAction SilentlyContinue | Out-Null; Set-ItemProperty -Path $msi -Name 'MSISupported' -Value 1 -Type DWord -ErrorAction SilentlyContinue } catch {};" ^
  "  try { New-Item -Path $aff -Force -ErrorAction SilentlyContinue | Out-Null; Set-ItemProperty -Path $aff -Name 'DevicePriority' -Value 3 -Type DWord -ErrorAction SilentlyContinue } catch {};" ^
  "}" >nul 2>&1

:: NVIDIA-specific MSI via PCI VEN_10DE
for /f "tokens=*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\PCI" /s /f "VEN_10DE" 2^>nul ^| findstr "HKEY"') do (
    reg add "%%a\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%a\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 3 /f >nul 2>&1
)
echo [OK] Section 20 complete.


:: ============================================================
::  SECTION 21 - GAME MODE + FULLSCREEN OPTIMIZATIONS
:: ============================================================
:S21
echo.
echo ============================================================
echo  [21/26] FORCE GAME MODE ON + DISABLE FSO
echo ============================================================
choice /c YN /n /m "Run section 21? [Y/N]: "
if errorlevel 2 goto :S22

reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
sc stop xbgm >nul 2>&1 & sc config xbgm start= disabled >nul 2>&1
echo [OK] Section 21 complete.


:: ============================================================
::  SECTION 22 - MEGA BEAST 15 ADVANCED TWEAK CATEGORIES
:: ============================================================
:S22
echo.
echo ============================================================
echo  [22/26] MEGA BEAST - 15 ADVANCED TWEAK CATEGORIES
echo ============================================================
choice /c YN /n /m "Run section 22? [Y/N]: "
if errorlevel 2 goto :S23

:: [B1] Timer resolution
reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config" /v "FrequencyCorrectRate" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config" /v "MinPollInterval" /t REG_DWORD /d 6 /f >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /set useplatformclock false >nul 2>&1
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set tscsyncpolicy Enhanced >nul 2>&1

:: [B2] Auto standby memory cleanup task
powershell -NoProfile -Command "$code = @'
using System; using System.Runtime.InteropServices;
public class MemClean {
[DllImport(\"ntdll.dll\")] public static extern int NtSetSystemInformation(int InfoClass, IntPtr Info, int Length);
[DllImport(\"advapi32.dll\")] public static extern bool OpenProcessToken(IntPtr p, int a, ref IntPtr t);
[DllImport(\"advapi32.dll\")] public static extern bool LookupPrivilegeValue(string h, string n, ref long l);
[DllImport(\"advapi32.dll\")] public static extern bool AdjustTokenPrivileges(IntPtr t, bool d, ref TP n, int b, IntPtr p, IntPtr r);
[DllImport(\"kernel32.dll\")] public static extern IntPtr GetCurrentProcess();
[StructLayout(LayoutKind.Sequential)] public struct TP { public int Count; public long Luid; public int Attr; }
public static void Clean() {
IntPtr t = IntPtr.Zero; long luid = 0;
OpenProcessToken(GetCurrentProcess(), 0x28, ref t);
LookupPrivilegeValue(null, \"SeProfileSingleProcessPrivilege\", ref luid);
TP tp = new TP(); tp.Count = 1; tp.Luid = luid; tp.Attr = 2;
AdjustTokenPrivileges(t, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero);
IntPtr p = Marshal.AllocHGlobal(4); Marshal.WriteInt32(p, 4);
NtSetSystemInformation(80, p, 4); Marshal.FreeHGlobal(p);
}}
'@; Add-Type -TypeDefinition $code; [MemClean]::Clean()" >nul 2>&1
schtasks /create /tn "AutoMemClean" /tr "powershell -WindowStyle Hidden -Command \"[GC]::Collect()\"" /sc minute /mo 1 /ru SYSTEM /f >nul 2>&1

:: [B3] NVIDIA hidden registry tweaks
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "ThreadedOptimization" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "PrerenderLimit" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableDynamicPstate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RMHdcpKeyglobZero" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "PerfLevelSrc" /t REG_DWORD /d 8738 /f >nul 2>&1
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak" /v "TextureQuality" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCacheSizeMB" /t REG_DWORD /d 10240 /f >nul 2>&1
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak" /v "ShaderCacheSizeMB" /t REG_DWORD /d 10240 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\DirectX" /v "ShaderCache" /t REG_DWORD /d 10240 /f >nul 2>&1

:: [B4] NVMe SSD I/O scheduler
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "IoLatencyCap" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "HwTimeout" /t REG_DWORD /d 0 /f >nul 2>&1

:: [B5] Gameloop / PUBG process priorities + GPU preference
for %%P in (
    AndroidEmulator.exe
    AndroidEmulatorEn.exe
    AndroidEmulatorEx.exe
    AndroidEmulatorPUBG.exe
    aow_exe.exe
    aow_boot.exe
    cef_frame_render.exe
    AppMarket.exe
    GameLoop.exe
    GameDownload.exe
    TxGameDownload.exe
    TxGameAssistant.exe
) do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%P\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%P\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%P\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "%%P" /t REG_SZ /d "GpuPreference=2;" /f >nul 2>&1
)
reg add "HKLM\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "VRROptimizeEnable=0;" /f >nul 2>&1

:: [B6] Pagefile fixed (16-24GB)
wmic computersystem where name="%COMPUTERNAME%" set AutomaticManagedPagefile=False >nul 2>&1
wmic pagefileset where name="C:\\pagefile.sys" delete >nul 2>&1
wmic pagefileset create name="C:\\pagefile.sys" >nul 2>&1
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=16384,MaximumSize=24576 >nul 2>&1

:: [B7] Defender exclusions for Gameloop
powershell -NoProfile -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\TxGameAssistant' -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Add-MpPreference -ExclusionPath 'C:\Program Files (x86)\TxGameAssistant' -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Add-MpPreference -ExclusionPath \"$env:LOCALAPPDATA\TxGameAssistant\" -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Add-MpPreference -ExclusionPath \"$env:APPDATA\TxGameAssistant\" -ErrorAction SilentlyContinue" >nul 2>&1
for %%P in (AndroidEmulator.exe AndroidEmulatorEn.exe AndroidEmulatorEx.exe aow_exe.exe cef_frame_render.exe AppMarket.exe) do (
    powershell -NoProfile -Command "Add-MpPreference -ExclusionProcess '%%P' -ErrorAction SilentlyContinue" >nul 2>&1
)
echo [OK] Section 22 complete.


:: ============================================================
::  SECTION 23 - ANTI-STUTTER FIX (GAMELOOP/PUBG)
:: ============================================================
:S23
echo.
echo ============================================================
echo  [23/26] ANTI-STUTTER FIX (GAMELOOP/PUBG)
echo ============================================================
choice /c YN /n /m "Run section 23? [Y/N]: "
if errorlevel 2 goto :S24

:: Clear Gameloop shader caches
if exist "%LOCALAPPDATA%\TxGameAssistant\UI\ShaderCache" del /q /f /s "%LOCALAPPDATA%\TxGameAssistant\UI\ShaderCache\*" >nul 2>&1
if exist "%LOCALAPPDATA%\TxGameAssistant\AppMarket\ShaderCache" del /q /f /s "%LOCALAPPDATA%\TxGameAssistant\AppMarket\ShaderCache\*" >nul 2>&1
for /d %%D in ("C:\Program Files (x86)\TxGameAssistant\*ShaderCache*") do rd /s /q "%%D" >nul 2>&1
for /d %%D in ("C:\Program Files\TxGameAssistant\*ShaderCache*") do rd /s /q "%%D" >nul 2>&1

:: TDR delays (smoother frame delivery)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 60 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 60 /f >nul 2>&1

:: Print Spooler off
sc config "Spooler" start= demand >nul 2>&1
net stop "Spooler" >nul 2>&1

:: Kill background stutter processes
for %%P in (
    OneDrive.exe MicrosoftEdge.exe msedge.exe msedgewebview2.exe
    YourPhone.exe GameBar.exe GameBarPresenceWriter.exe
    SearchUI.exe SearchApp.exe Cortana.exe
    WidgetService.exe Widgets.exe RuntimeBroker.exe
    SecurityHealthSystray.exe
) do taskkill /f /im %%P >nul 2>&1
echo [OK] Section 23 complete.


:: ============================================================
::  SECTION 24 - CLEANUP TEMP / PREFETCH / SHADER CACHE / DNS
:: ============================================================
:S24
echo.
echo ============================================================
echo  [24/26] CLEANUP TEMP / PREFETCH / SHADER CACHE / DNS
echo ============================================================
choice /c YN /n /m "Run section 24? [Y/N]: "
if errorlevel 2 goto :S25

del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
del /f /s /q "%Temp%\*" >nul 2>&1
del /f /s /q "%SystemRoot%\Prefetch\*" >nul 2>&1
del /f /s /q "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
del /f /s /q "%LocalAppData%\NVIDIA\DXCache\*" >nul 2>&1
del /f /s /q "%LocalAppData%\NVIDIA\GLCache\*" >nul 2>&1
del /f /s /q "%LocalAppData%\D3DSCache\*" >nul 2>&1
del /f /s /q "%LocalAppData%\AMD\DxCache\*" >nul 2>&1
del /f /s /q "%LocalAppData%\AMD\GLCache\*" >nul 2>&1
if exist "%LOCALAPPDATA%\NVIDIA\DXCache" rd /s /q "%LOCALAPPDATA%\NVIDIA\DXCache" >nul 2>&1
if exist "%LOCALAPPDATA%\NVIDIA\GLCache" rd /s /q "%LOCALAPPDATA%\NVIDIA\GLCache" >nul 2>&1
if exist "%LOCALAPPDATA%\D3DSCache" rd /s /q "%LOCALAPPDATA%\D3DSCache" >nul 2>&1
if exist "%LOCALAPPDATA%\NVIDIA Corporation\NV_Cache" rd /s /q "%LOCALAPPDATA%\NVIDIA Corporation\NV_Cache" >nul 2>&1
del /q /f /s "%ProgramData%\Microsoft\Windows\WER\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache*" >nul 2>&1
del /q /f "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1
powershell -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
ipconfig /flushdns >nul 2>&1
echo [OK] Section 24 complete.


:: ============================================================
::  SECTION 25 - GROUP POLICY LOCKDOWNS (DEBLOATER)
:: ============================================================
:S25
echo.
echo ============================================================
echo  [25/26] GROUP POLICY LOCKDOWNS
echo ============================================================
choice /c YN /n /m "Run section 25? [Y/N]: "
if errorlevel 2 goto :S26

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUPowerManagement" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "SetDisableUXWUAccess" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowUnsolicited" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoAutoplayfornonVolume" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoAutorun" /t REG_DWORD /d 1 /f >nul 2>&1
gpupdate /force >nul 2>&1
echo [OK] Section 25 complete.


:: ============================================================
::  SECTION 26 - BIOS FLASH (auto_bios via SCEWIN_64) - HIGH RISK
:: ============================================================
:S26
echo.
echo ============================================================
echo  [26/26] BIOS FLASH via SCEWIN_64  ***HIGH RISK***
echo ============================================================
echo  This writes motherboard NVRAM. Wrong setting on wrong board
echo  can brick your motherboard. Gigabyte boards: do NOT run.
echo  Requires SCEWIN_64.exe in the same folder as this script.
echo.
choice /c YN /n /m "Run BIOS flash? [Y/N]: "
if errorlevel 2 goto :DONE

if not exist "%~dp0SCEWIN_64.exe" (
    echo [SKIP] SCEWIN_64.exe not found next to this script.
    echo Place SCEWIN_64.exe in "%~dp0" and rerun if you want BIOS tweaks.
    goto :DONE
)

echo.
choice /c IA /n /m "Motherboard CPU type - I=Intel  A=AMD: "
if errorlevel 2 goto :S26_AMD

:S26_INTEL
echo.
echo Running INTEL BIOS profile...
"%~dp0SCEWIN_64.exe" /i /ms "Global C-state Control" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PS2 Devices Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "TPM State" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Secure Boot" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Secure Boot" /qv 0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Fast Boot" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Power On By Mouse" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Power On By Keyboard" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Wake on LAN" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Bootup NumLock State" /qv 0x1 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Network Stack Driver Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "XHCI Hand-Off" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Legacy USB Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Resume by Alarm" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Full Screen LOGO Show" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Security Device Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "CNVI Mode" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Intel RMT State" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Intel Ready Mode Technology" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Energy Efficient P-state" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Energy Performance Gain" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Energy Efficient Turbo" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "BME DMA Mitigation" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Enable RH Prevention" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Per Bank Refresh" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Intel(R) SpeedStep(tm)" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "CPU C-States" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Intel(R) Speed Shift Technology" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "ME State" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Power Down Mode" /qv 0x0 /lang en-US
:: typo preserved exactly as in original auto_bios.bat:
CEWIN_64.exe /i /ms "Energy Efficient Turbo" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "command Rate Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "RC6(Render Standby)" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Type C Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "LAN Wake From DeepSx" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PCH Cross Throttling" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Power Down Unused Lanes" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "ACPI Standby State" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "USB2 PHY Sus Well Power Gating" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "HW Notification" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "DMI Link ASPM Control" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PCIe Spread Spectrum Clocking" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "C6DRAM" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Intel Virtualization Tech" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "CPU AES Instructions" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "EIST" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Race To Halt" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Intel Adaptive Thermal Monitor" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "HDC Control" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "SMM Code Access Check" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "SMM Use Delay Indication" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "SMM Use Block Indication" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "SMM Use SMM en-US Indication" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "LTR" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "I/O Resources Padding" /qv 0x20 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "MMIO 32 bit Resources Padding" /qv 0x80 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PFMMIO 32 bit Resources Padding" /qv 0x80 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PFMMIO 64 bit Resources Padding" /qv 0x2000 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "CWIFI SAR" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "WWAN Reset Workaround" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "WWAN Device" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "1394 controller" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "CPU Spread Spectrum" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Execute Disable Bit" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "iGPU Multi-Monitor" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PEP TBT RP" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PEP LAN(GBE)" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PEP CSME" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PEP SDXCE" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PEP EMMC" /qv 0x0 /lang en-US
goto :DONE

:S26_AMD
echo.
echo Running AMD BIOS profile...
"%~dp0SCEWIN_64.exe" /i /ms "Global C-state Control" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "TPM State" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Secure Boot" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Secure Boot" /qv 0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Fast Boot" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Power On By Mouse" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Power On By Keyboard" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Wake on LAN" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Bootup NumLock State" /qv 0x1 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "CSM Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Network Stack Driver Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "HD Audio Controller" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "XHCI Hand-Off" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Legacy USB Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Resume by Alarm" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Full Screen LOGO Show" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Security Device Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "CNVI Mode" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Energy Efficient P-state" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Energy Performance Gain" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Energy Efficient Turbo" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "BME DMA Mitigation" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Enable RH Prevention" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "IOMMU" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "AMD Cool'N'Quiet" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Serial / Parallel Port" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "AMD fTPM switch" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Remote Display Feature" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PSS Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "AB Clock Gating" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PCIB Clock Run" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "SR-IOV Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Opcache Control" /qv 0x1 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Opcache Control" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Above 4G memory" /qv 0x1 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Adaptive S4" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "LAN Power Enable" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PM L1 SS" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Win7 USB Wake Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "AMD Cool&Quiet function" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "C6 Mode" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PCIe Slot Configuration" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "3DMark01 Enhancement" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Isochronous Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "PS2 Devices Support" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Enable Hibernation" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Onboard PCIE LAN PXE ROM" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "CRB test" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Integrated Graphics" /qv 0x0 /lang en-US
"%~dp0SCEWIN_64.exe" /i /ms "Aggressive Link PM Capability" /qv 0x0 /lang en-US


:DONE
echo.
echo ============================================================
echo   GODMODE MERGED 2026 - SELECTED SECTIONS COMPLETE
echo ============================================================
echo.
echo  Backups: C:\GodModeBackup\
echo  Log:     %LOGFILE%
echo.
echo  Reboot REQUIRED for VBS/HVCI/BCD/MSI/Defender changes.
echo.
choice /c YN /n /m "Reboot now? [Y/N]: "
if errorlevel 2 (
    echo  Reboot skipped. Run it manually when ready.
    pause
    exit /b 0
)
shutdown /r /t 5 /c "GODMODE MERGED 2026 - Rebooting..."
exit /b 0
