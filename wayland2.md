# The Ultimate High-Performance Wayland Guide (Arch Linux)

This document is a comprehensive resource for building a Wayland environment on Arch Linux that prioritizes speed, modernity, and low-level efficiency (C, C++, Rust, Zig). The goal is to create a system that outpaces KDE and COSMIC while maintaining a premium, feature-complete experience.

---

## 🏗️ 1. Wayland Compositors (Window Managers)

The compositor is the heart of your system. These options focus on modern protocols and high-performance languages.

| Name | Language | Age | Updates | Fork? | Customizability | Style |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Hyprland** | C++ | 2022 | **Daily** | No | **Highest** | Dynamic Tiling |
| **Niri** | **Rust** | 2023 | **Weekly** | No | High | Scrollable Tiling |
| **River** | **Zig** | 2020 | Active | No | **Extreme** | Dynamic Tiling |
| **Sway** | C | 2016 | Stable | No | High | i3-style Tiling |
| **Labwc** | C | 2021 | Active | Inspired by Openbox | Moderate | Stacking |
| **Wayfire** | C++ | 2018 | Active | No | High | 3D/Effects |
| **Dwl** | C | 2020 | Active | dwm port | Moderate | Minimal Tiling |
| **Cosmic-Comp**| **Rust** | 2023 | **Daily** | No | High | Dynamic Tiling |

---

## 🛠️ 2. Core Supporting Components

To build a full DE-like experience, you need high-performance tools for each of these categories.

### 🚀 App Launchers
| Name | Language | Age | Speed | Customizability |
| :--- | :--- | :--- | :--- | :--- |
| **Tofi** | C | 2021 | **Frame-perfect** | High (Scriptable) |
| **Fuzzel** | C | 2020 | **Blazing** | High (CSS) |
| **Rofi-Wayland**| C | 2021 | Fast | **Highest** (.rasi) |
| **Anyrun** | **Rust** | 2022 | Fast | High (Plugins) |
| **Bemenu** | C | 2017 | **Blazing** | Moderate |

### 🔔 Notification Systems
| Name | Language | Age | Updates | Features |
| :--- | :--- | :--- | :--- | :--- |
| **Mako** | C | 2018 | Active | Lightweight, logic-based styling. |
| **SwayNC** | C/Vala | 2021 | Active | Full Control Center UI. |
| **Fnott** | C | 2022 | Active | Keyboard-driven, ultra-minimal. |
| **Wired** | **Rust** | 2023 | Active | Block-based placement/logic. |

### 📂 File Managers
| Name | Language | Age | Speed | Notes |
| :--- | :--- | :--- | :--- | :--- |
| **Yazi** | **Rust** | 2023 | **Fastest** | Terminal-based, GPU rendering. |
| **Cosmic-Files**| **Rust** | 2024 | Fast | Modern GUI, Rust-based. |
| **Thunar** | C | 2009 | Fast | Lightweight classic (GTK). |
| **Dolphin** | C++ | 2006 | Moderate | Full-featured KDE standard. |

### 🔒 Security (Lock & Idle)
| Name | Category | Language | Updates | Notes |
| :--- | :--- | :--- | : :--- | :--- |
| **Hyprlock** | Lock Screen | C++ | **Extreme** | GPU accelerated, multi-threaded. |
| **Swaylock** | Lock Screen | C | Stable | Simple, PNG-based. |
| **Hypridle** | Power/Idle | C++ | Active | Modern, works with any compositor. |
| **Wlsunset** | Power/Lux | C | Active | Gamma/Temp adjustment (Blue light). |

### 📋 Clipboard & Session
| Name | Category | Language | Updates | Notes |
| :--- | :--- | :--- | :--- | :--- |
| **Uwsm** | Session Mgr | **Rust** | Active | Minimal overhead, systemd integration. |
| **Greetd** | Login Mgr | C | Active | Generic "greeter" daemon. |
| **Ly** | Login Mgr | **Zig** | Active | TUI-based display manager. |
| **Cliphist** | Clipboard | Go/Rust | Active | Bit-perfect text/image history. |
| **Wl-clip-persist**| Clipboard | C | Active | Prevents clipboard loss on app close. |

---

## 🏆 The "Performance King" Recommended Stack

If you want to outdo KDE/COSMIC today, this is the stack to build:

1.  **Compositor**: **Hyprland** (C++) – The best combination of modern features (animations, blur) and raw performance.
2.  **Status Bar**: **Waybar** (C++) – JSON/CSS driven, extremely fast.
3.  **App Launcher**: **Tofi** (C) – Renders within a single frame; nothing is faster.
4.  **Notifications**: **Mako** (C) – Invisible resource usage, logic-based control.
5.  **File Manager**: **Yazi** (Rust) – Async IO and GPU rendering make GUI managers feel like relics.
6.  **Wallpaper**: **Swww (Awww)** (Rust) – Daemon-based, GPU-accelerated transitions.
7.  **Terminal**: **Foot** (C) – The fastest Wayland-native terminal.
8.  **Login**: **Greetd** + **Tuigreet** (Rust) – Clean, fast, safe.

---

## ⚡ InstallationQuick Start

Install the "Performance King" stack on Arch:

```bash
sudo pacman -S hyprland waybar tofi mako yazi hyprlock hyprpaper hypridle cliphist foot greetd-tuigreet
```

### One-Time Configuration Strategy
These tools use text-based configs that rarely need changing once set.
- **Hyprland**: `~/.config/hypr/hyprland.conf` (Uses Hyprlang)
- **Waybar**: `~/.config/waybar/config` & `style.css` (JSON/CSS)
- **Mako**: `~/.config/mako/config` (INI style)
- **Tofi**: `~/.config/tofi/config` (Key-value)

---

## 📊 Conclusion: Why This Beats a DE
- **Resource Usage**: Idle RAM < 300MB (KDE/COSMIC are 800MB - 1.2GB).
- **Latency**: Direct-to-hardware rendering with no XWayland translation for core tools.
- **Boot Speed**: System is ready to use in ~2 seconds after login.
- **Memory Safety**: Many core components are written in **Rust**, preventing common segfaults found in older C/C++ DEs.
