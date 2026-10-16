# ◈ cult-of-maxwellism // dotfiles

<p align="center">
  <img src="assets/screenshots/preview.svg" alt="Desktop Setup Preview" width="100%">
</p>

<p align="center">
  <a href="https://archlinux.org/"><img src="https://img.shields.io/badge/OS-Arch%20Linux-1793D1?style=flat-square&logo=arch-linux&logoColor=white" alt="Arch Linux"></a>
  <a href="https://www.gnu.org/software/stow/"><img src="https://img.shields.io/badge/Managed%20With-GNU%20Stow-4EAA25?style=flat-square" alt="GNU Stow"></a>
  <a href="https://i3wm.org/"><img src="https://img.shields.io/badge/WM-i3--gaps%20%2F%20KDE-black?style=flat-square" alt="i3 / KDE"></a>
  <a href="https://neovim.io/"><img src="https://img.shields.io/badge/Editor-Neovim%200.10+-57A143?style=flat-square&logo=neovim&logoColor=white" alt="Neovim"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square" alt="License: MIT"></a>
</p>

---

## Overview

A curated, Git-backed and [GNU Stow](https://www.gnu.org/software/stow/)-managed repository of personal Linux configurations, aesthetic customizations, and desktop ricing assets. Designed for rapid deployment, modular package management, and zero-headache recovery.

> **Current Workflow Stage:** Dual-session daily driver (KDE Plasma Wayland + i3-gaps X11 fallback), stepping towards an automated Hyprland workstation with rapid theme-switching capabilities.

---

## 🛠 Tech Stack & Aesthetics

| Component | Software / Configuration | Details |
|---|---|---|
| **OS** | [Arch Linux](https://archlinux.org/) | Rolling release |
| **Window Managers** | [i3-gaps](https://i3wm.org/) / [KDE Plasma](https://kde.org/plasma-desktop/) | Dual X11/Wayland environment |
| **Bar** | [Polybar](https://github.com/polybar/polybar) | Customized Gruvbox `forest` theme + custom modules |
| **Terminal** | [Kitty](https://sw.kovidgoyal.net/kitty/) | `Sundried` colorway, GPU accelerated |
| **Shells** | [Bash](https://www.gnu.org/software/bash/) & [Fish](https://fishshell.com/) | Interactive prompt + POSIX login scripts |
| **App Launcher** | [Rofi](https://github.com/davatorium/rofi) | Gruvbox sidebar style |
| **Editor** | [Neovim](https://neovim.io/) | Lua config powered by `lazy.nvim`, Treesitter, Telescope |
| **Typography** | [Libertinus Mono](https://github.com/alerque/libertinus) & Serif Display | Editorial serif & distinct monospace typesetting |
| **GTK / Qt Themes** | Breeze-Dark & [kvantum-dark](https://github.com/tsujan/Kvantum) | Unified dark toolkit styles |
| **Cursor Theme** | [WhiteSur-cursors](https://github.com/vinceliuice/WhiteSur-cursors) | Smooth 24–48px dark pointers |
| **Wallpaper** | ThinkPad schematic artwork | Managed via `feh` |

---

## 📁 Repository Structure

Each directory functions as an independent **GNU Stow package** that mirrors the user's `$HOME`:

```text
~/.config/dotfiles/
├── assets/             # Screenshots and preview media
├── bash/               # ~/.bashrc, ~/.bash_profile, ~/.bash_logout
├── fish/               # ~/.config/fish/config.fish, fish_variables
├── gtk/                # GTK 3.0, GTK 4.0, xsettingsd, legacy .gtkrc
├── i3/                 # ~/.config/i3/config (inner/outer gaps, shortcuts)
├── kde-theme/          # ~/.config/kdeglobals, kwinrc, plasmarc
├── kitty/              # ~/.config/kitty/kitty.conf, current-theme.conf
├── neofetch/           # ~/.config/neofetch/config.conf
├── nvim/               # ~/.config/nvim/ (init.lua, lazy-lock, plugins)
├── polybar/            # ~/.config/polybar/ (launch.sh, forest Gruvbox theme)
├── qt/                 # ~/.config/qt6ct/qt6ct.conf
├── rofi/               # ~/.config/rofi/config.rasi
├── x11/                # ~/.Xresources, ~/.xprofile, ~/.fehbg
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🚀 Installation & Stow Deployment

### 1. Clone the repository

```bash
git clone git@github.com:cult-of-maxwellism/dotfiles.git ~/.config/dotfiles
cd ~/.config/dotfiles
```

### 2. Deploy all packages

To link every configuration to `$HOME`:

```bash
stow -v -t ~ bash fish gtk i3 kde-theme kitty neofetch nvim polybar qt rofi x11
```

Or deploy individual components on demand:

```bash
stow -v -t ~ kitty nvim   # Only terminal and editor
stow -v -t ~ i3 polybar   # Only window manager and status bar
```

### 3. Restowing & Rolling Back (Quick Recovery)

If you modify configurations or need to re-synchronize links:

```bash
# Refresh / re-link packages
stow -R -v -t ~ <package-name>

# Unlink a package safely
stow -D -v -t ~ <package-name>
```

---

## 📦 Recommended System Packages

### Arch Linux (pacman & yay)

```bash
# Core desktop & ricing utilities
sudo pacman -S --needed \
    i3-gaps polybar rofi kitty neofetch feh xss-lock \
    brightnessctl network-manager-applet pavucontrol pulseaudio-utils \
    stow git rsync fish

# Editor & Development
sudo pacman -S --needed neovim ripgrep fd fzf

# Fonts & Appearance
sudo pacman -S --needed \
    ttf-libertinus ttf-nerd-fonts-symbols-common \
    qt6ct kvantum breeze-gtk
```

---

## 🎨 Color Palette & Theming Reference

- **Terminal (Kitty Sundried):**
  - Background: `#1a1818` | Foreground: `#c8c8c8`
  - Accent / Red: `#a6463d` | Green: `#577644` | Blue: `#485a98`
- **Polybar (Forest Gruvbox):**
  - Background: `#282828` | Foreground: `#ebdbb2`
  - Accent Red: `#fb4934` | Aqua: `#8ec07c` | Dark Accent: `#313131`

---

## 📄 License

This repository is licensed under the [MIT License](LICENSE).
Feel free to fork, adapt, and rice!
