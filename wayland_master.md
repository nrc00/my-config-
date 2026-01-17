# The Master Wayland Guide: Ultimate High-Performance Arch Setup

This document is the result of a comprehensive merge of all Wayland research, component analysis, and metadata. It prioritizes the fastest languages (**C, C++, Rust, Zig**) and the most modern, active projects to outdo traditional desktop environments.

---

## 🏗️ 1. Wayland Compositors (Window Managers)

The heart of your setup. These options are chosen for their efficiency and modern feature sets.

| Name | Language | Status | Age | Fork? | Customizability | Style |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Hyprland** | C++ | **Daily** | 2022 | No | **Highest** | Dynamic Tiling + Eye Candy |
| **Niri** | **Rust** | **Weekly** | 2023 | No | **Very High** | Scrollable Tiling |
| **River** | **Zig** | **Weekly** | 2020 | No | **Extreme** | Scriptable Dynamic Tiling |
| **Sway** | C | Stable | 2016 | No | High | i3-compatible Tiling |
| **Labwc** | C | Active | 2021 | Inspired by Openbox | Moderate | Stacking |
| **Wayfire** | C++ | Active | 2018 | No | High | 3D/Compiz-like plugins |
| **Dwl** | C | Active | 2020 | dwm port | Moderate | Minimalist |
| **Cosmic-Comp**| **Rust** | **Daily** | 2023 | No | High | Modern Desktop Shell |
| **Maomaowm** | **Rust** | Active | 2023 | No | Moderate | Minimal Animated Tiling |

**Performance Ranking**: Niri > Hyprland > River > Dwl > Labwc

---

## 🔔 2. Notification Systems

| Name | Language | Updates | Age | Fork? | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Mako** | **C** | **Weekly** | 2018 | No | Ultra-minimal, CSS-style logic. |
| **SwayNC** | C/Vala | Bi-weekly | 2021 | No | Feature-rich Control Center. |
| **Fnott** | **C** | Monthly | 2022 | No | Ultra-minimal, keyboard focused. |
| **Dunst** | **C** | Monthly | 2017 | No | Mature classic, Wayland-native. |
| **Wired** | **Rust** | Rare | 2023 | No | Layout blocks for complex alerts. |

---

## 📂 3. File Managers

| Name | Language | Status | Age | Wayland | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Yazi** | **Rust** | **Extreme** | 2023 | **Native** | TUI, GPU image rendering, blazingly fast. |
| **Cosmic-Files**| **Rust** | **Daily** | 2024 | **Native** | Modern GUI, tabbed, part of COSMIC. |
| **Thunar** | C/GTK | Weekly | 2009 | GTK3/4 | XFCE stable, lightweight. |
| **Nautilus** | C/GTK | Weekly | 1999 | GTK4 | Feature-heavy GNOME standard. |

---

## 🚀 4. App Launchers

| Name | Language | Speed | Age | Fork? | Customizability |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Tofi** | **C** | **Frame-perfect** | 2022 | No | High (Simple scriptable logic) |
| **Fuzzel** | **C** | **Blazing** | 2021 | No | High (CSS styling) |
| **Bemenu** | **C** | **Blazing** | 2019 | No | High (dmenu-like) |
| **Anyrun** | **Rust** | Fast | 2022 | No | **Extreme** (Plugin-based) |
| **Wofi** | C/GTK | Fast | 2020 | No | High (CSS) |
| **Rofi (Fork)** | C | Fast | 2023 | Yes | Highest (Uses `.rasi`) |

---

## 🖼️ 5. Wallpaper & Aesthetics

| Name | Language | Updates | Type | GPU Accel | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Swww (Awww)** | **Rust** | **Weekly** | Daemon | **Yes** | <16ms transitions (Single frame). |
| **Hyprpaper** | **C++** | Bi-weekly | Daemon | **Yes** | High reliability for Hyprland users. |
| **Wpaperd** | **Rust** | Monthly | Daemon | Yes | Modern Rust utility. |
| **WayBar** | **C++** | **Extensive** | Sidebar | Yes | JSON/CSS powered status bar. |

---

## 🔒 6. Security, Idle & Session

| Name | Category | Language | Status | Notes |
| :--- | :--- | :--- | :--- | :--- |
| **Hyprlock** | Lock Screen | **C++** | **Daily** | GPU accelerated, multi-threaded. |
| **Swaylock** | Lock Screen | **C** | Stable | Simple, reliable PNG locker. |
| **Hypridle** | Idle/Power | **C++** | Active | Modern daemon with multi-protocol support. |
| **Wlsunset** | Blue Light | **C** | Active | Gamma/Temperature control. |
| **Uwsm** | Session Mgr | **Rust** | Active | Lightweight session management (Systemd). |
| **Greetd** | Login Mgr | **C** | Active | Clean, fast "greeter" daemon. |

---

## 📋 7. Clipboard Managers

| Name | Language | History | Type | Notes |
| :--- | :--- | :--- | :--- | :--- |
| **Wl-clip-persist**| **C** | No | Daemon | **Essential**: Prevents data loss on app close. |
| **Cliphist** | **Rust** | Yes | CLI | Robust history for text/images. |
| **Clipse** | **Rust** | Yes | **TUI** | Single binary history management. |

---

## 🎯 RECOMMENDED "ULTIMATE" STACK

This configuration is designed to yield the highest performance vs. feature ratio on Arch Linux (Memory idle < 300MB).

| Role | Choice | Rationale |
| :--- | :--- | :--- |
| **Compositor** | **Hyprland** | Best aesthetics/speed ratio; active development. |
| **Launcher** | **Tofi** | Measured as one of the lowest-latency launchers. |
| **Notifications** | **Mako** | Invisible resource footprint. |
| **File Manager** | **Yazi** | Rust + Async + GPU rendering = zero lag. |
| **Wallpaper** | **Swww** | Best animation engine in the ecosystem. |
| **Lock Screen** | **Hyprlock** | Most visually impressive while staying fast. |
| **Terminal** | **Foot** | Fastest native Wayland terminal emulator. |
| **Session** | **Uwsm** | Clean integration with current Arch standards. |

### 🏎️ Performance Comparison
- **Boot Speed**: ~2s (Custom) vs ~8s (KDE/COSMIC).
- **RAM Usage**: <300MB (Custom) vs ~1GB (Full DE).
- **Latency**: Direct-to-composite rendering (Lower input lag).

### 🔧 Installation Query (Arch)
```bash
sudo pacman -S hyprland tofi mako yazi swww foot hyprlock hypridle uwsm cliphist waybar
```
