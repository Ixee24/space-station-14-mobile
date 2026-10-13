# Space Station 14 - Mobile (Android)

Android port of [Space Station 14](https://github.com/space-wizards/space-station-14).

> [!WARNING]
> **Disclaimer / unofficial client**
> 
> This android port is NOT provided or supported by Space Wizards Federation, and is an independent community project.
> 
> * **Use at your own risk:** Stability, controls, and performance may vary depending on your device.
> * **Do not report mobile-specific issues (crashes, low FPS, UI bugs) via in-game ahelp or to the official Wizard's Den staff.**
> * If you encounter bugs or performance problems related to the Android build, please report them directly in the [Issues](https://github.com/Ixee24/space-station-14-mobile/issues) section of this repository.

---

## Major Features

### 🎮 Multi-Codebase & Fork Support (Universal Playability)
* **Prototype Isolation:** Dynamic VFS filtering isolates the baked-in content pack when joining external servers via `--mount-zip`. Custom server prototypes (Frontier Station, Goob Station, Starlight, DeltaV, RUMC, Corvax, Wizard's Den, etc.) load cleanly without duplicate IDs, namespace pollution, or missing RSI collisions.
* **Engine Core & Legacy Compatibility:** Broad compatibility across modern and legacy engine cores (v267–v292+), featuring runtime API shims and defensive prototype fallbacks (e.g., UI color palettes) for custom community forks.
* **Automatic Resource Sync:** Embedded base resources automatically refresh across app updates to guarantee fresh shader, font, and UI palette assets.
* **Standalone / Offline Mode:** The baked-in content pack automatically mounts when playing offline sandbox.

### 🛡️ Subprocess Isolation (`:game`)
* **Process Separation:** The game engine runs inside an isolated Android Linux sub-process (`io.spacestation14.android:game`) completely separate from the launcher.
* **Zero Memory Leaks:** Exiting or disconnecting from a server completely terminates the `:game` process, purging all static variables, dynamic assemblies, and GPU contexts. Every session starts with a 100% clean memory slate.
* **Crash Resilience:** If an unhandled native or engine crash occurs during gameplay, the launcher process remains unaffected and instantly offers an in-app crash report.

### ⭐ Server Hub, Direct Connect & Favorites
* **Hub Browser:** Live server hub listing with player counts, round status, and real-time search & filter.
* **Favorites System:** Star any server from the hub or direct connect list to pin it to your Favorites tab.
* **Direct Connect:** Connect to any server IP, domain, or `ss14://` link with custom naming and persistent history.
* **Content Cache Management:** Content-hash addressed download cache with automatic cleanup of outdated builds upon server updates.

### 📱 Touch Controls & UI
* **True Multi-Touch:** Independent finger tracking for virtual controls and simultaneous button presses while moving.
* **Pojav-Style Virtual Buttons:** Fast, responsive on-screen buttons mapped to keybinds:
  * **USE (E):** Primary interaction / activate object
  * **SEC (Z):** Secondary interaction / use in hand
  * **HAND (X):** Swap active hand
  * **DROP (Q):** Drop held item
  * **ALT (Alt):** Alt-click interaction
  * **EXAM (Shift):** Examine entity
  * **PULL (Ctrl):** Toggle pulling
  * **BAG (V):** Open/close backpack and storage inventory
  * **THROW (Ctrl+Q):** Throw held item
  * **KBD:** Toggle virtual keyboard
* **SHOW / HIDE Controls:** Clean toggle to show or hide the virtual overlay, automatically releasing any held actions upon hiding.
* **In-Game EDIT Mode:** Drag, reposition, scale, and adjust opacity for every control button and thumbstick in real-time.
* **Touch Gestures:** Native touch-scrolling across all menus, crafting trees, storage containers, PDA, and chatbox; touch header dragging for movable windows.
* **Hardware Keyboard Detection:** Automatic detection of physical USB/Bluetooth keyboards to suppress the soft keyboard.

### ⚡ Performance & Display Customization
* **Resolution Scaling:** Choose between Native, 1080p, 900p, and 720p Surface scaling presets to balance crisp visual fidelity with battery life and thermal efficiency.
* **Display UI Scaling:** Independent in-game HUD and UI scaling adjustments.
* **Frame Rate Control:** Configurable 60 FPS cap, VSync toggles, and mobile lighting optimizations.

### 📋 In-App Crash Reporter & Logs (No PC / Logcat Needed)
* **Automatic Detection:** Automatically detects prior session crashes upon returning to the launcher.
* **One-Tap Export:** View crash stack traces, logs, and touch layout dumps directly on-device with Copy to Clipboard or native Android Share Sheet integration.

---

## Requirements

* **OS:** Android 8.0+ (API 26+)
* **Architecture:** ARM64 (`arm64-v8a`)
* **Graphics:** OpenGL ES 3.0+ / Vulkan
* **Storage:** ~120 MB for installation + space for server content caches

---

## Architecture

* `Content.Android/` - Android native application, launcher UI, touch overlay, and download services.
* `space-station-14/` - Upstream Space Station 14 content (Git submodule).
* `RobustToolbox/` - RobustToolbox engine (Git submodule).
* `patches/` - Mobile adaptations, SDL3 EGL display surfaces, touch dispatchers, and prototype filtering.

---

## Building & Releases

Continuous Integration builds and publishes signed release APKs on every push to `master` via GitHub Actions:
[Build Android Release Workflow](https://github.com/Ixee24/space-station-14-mobile/actions)

---

## Credits

- Initial port, native builds & launcher: **[SolomonNumb1](https://github.com/SolomonNumb1)**
- Multi-touch, virtual controls, crash diagnostics & legacy compatibility: **[Ixee24](https://github.com/Ixee24)**

