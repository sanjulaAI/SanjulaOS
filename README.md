# SanjulaOS

JARVIS-themed all-in-one Windows toolkit. Silver Surfer wallpaper, chrome+neon UI, time-based greeting.

## Launch

```powershell
irm https://raw.githubusercontent.com/sanjulaAI/SanjulaOS/main/launcher.ps1 | iex
```

## Features

- **Install Apps** - 6 categories of winget apps with one-click install
- **Tweaks** - 30+ Windows tweaks, each individually toggleable (APPLY / REVERT buttons per tweak)
- **Monitor** - Live CPU/RAM/Disk + network info + ping test
- **Tools** - Safe info/fix bricks + 6 high-risk mega batch scripts (red bricks, multi-step warnings)

## Tweak categories

Privacy, UI/Appearance, Search/Cortana, Performance, Updates, Explorer, Network, Apps, Power, Safety

Each tweak has Apply AND Revert buttons. Hover for description tooltip.

## Risk levels

- **Cyan bricks** = safe
- **Red bricks** = high risk, requires confirmation
- **Auto BIOS** = extreme risk, double confirmation

## Structure

```
SanjulaOS/
├── launcher.ps1            # Main GUI
├── SILVER_SURFER.png       # Background
├── config/
│   ├── apps.json
│   ├── tweaks.json
│   └── custom.json
├── scripts/
│   ├── tweak-engine.ps1    # All Apply/Revert logic
│   ├── custom-*.ps1        # Tool buttons
│   └── ...
└── batch/                  # Risky .bat scripts
```
