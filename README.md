# Space Station 14 - Mobile (Android)

Android port of [Space Station 14](https://github.com/space-wizards/space-station-14).

> [!WARNING]
> **Disclaimer / unofficial client**
> 
> This android port is NOT provided or supported by Space Wizards Federation, and at that moment more like proof of work.
> 
> * **Use at your own risk:** Stability, controls, and performance may vary depending on your device
> * **Do not report mobile specific issues (crashes, low fps, ui bugs) via in game ahelp or to the official Wizard's Den staff**
> * If you encounter bugs or performance problems related to the Android build, please report them directly in the section [issues](https://github.com/SolomonNumb1/space-station-14-mobile/issues) of this repository
> * NEVERTHELESS, the project will be supported and improved

## Features
- **True Multi-Touch:** Independent finger tracking for virtual controls and simultaneous button presses while moving.
- **Swipe / Drag Scrolling:** Native swipe scrolling across all menus, crafting windows, storage containers, PDA, and lists.
- **Customizable Layout:** Move, resize, and add custom key buttons via in-game **EDIT** mode.
- **In-Game Window Dragging:** Movable windows and storage containers via touch headers.
- **Server Cache Management:** Automatic purging on server updates and idle cache pruning to prevent storage bloat.
- **In-App Logs & Crash Reporter:** View and share logs, dumps, and crash diagnostics directly from the launcher.

## Server Compatibility
- Can only join servers running the exact same build version as this APK (Space Station 14 / RobustToolbox v292)
- At that moment servers with different versions or custom forks are not supported (some is supported) ...because on pc the engines are download from a CDN, whereas on android none of the engines are pre compiled...

## Controls
- **Virtual Thumbstick:** 8-way movement with independent touch tracking
- **USE (E):** Primary interaction / activate object
- **SEC (Z):** Secondary interaction / use in hand
- **HAND (X):** Swap active hand
- **DROP (Q):** Drop item
- **ALT (Alt):** Alt-click interaction
- **EXAM (Shift):** Examine entity
- **PULL (Ctrl):** Toggle pulling
- **BAG (V):** Open/close backpack and storage inventory
- **THROW (Ctrl+Q):** Throw held item
- **KBD:** Toggle soft keyboard
- **HIDE:** Toggle on-screen touch controls visibility
- **EDIT:** Drag and customize control layout in-game
- **Gestures:**
  - Swipe up/down to scroll menus and lists
  - Drag window headers to reposition windows
  - Pinch to zoom viewport

## Settings (Launcher)
- Controls Scale & Opacity
- Joystick Size & GUI Scaling
- Display Resolution & FPS Limit
- Server Cache Management (Auto-purge on update, Clear Cache button)

## Requirements
- Android 8.0+ (API 26+)
- ARM64 (`arm64-v8a`)
- OpenGL ES 3.0+

## Architecture
- `Content.Android/` - Android app & launcher
- `space-station-14/` - Upstream Space Station 14 (Git submodule)
- `RobustToolbox/` - RobustToolbox engine (Git submodule)
- `patches/` - Mobile & client fixes

## Building
Built via GitHub Actions (`.github/workflows/android-release.yml`).

## Credits
- Initial port, native builds & launcher: **[SolomonNumb1](https://github.com/SolomonNumb1)**
- Multi-touch, swipe scrolling & crash reporter: **[Ixee24](https://github.com/Ixee24)**

## License & Legal
This project is open-source under the [MIT License](LICENSE).
For full legal disclaimers, trademark notices, and third-party attributions, please refer to [LEGAL.md](LEGAL.md).
"Space Station 14" and "RobustToolbox" are copyrighted by the Space Wizards Federation and individual contributors.
This project is an independent community project and is not affiliated with or endorsed by the Space Wizards Federation.
