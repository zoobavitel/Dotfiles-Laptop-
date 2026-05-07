# Dotfiles for my laptop

Hi! These are the dotfiles I use on my laptop.

## Overview

This repository contains my personal configuration files for a laptop setup. It is kept very close to my desktop setup, with only small laptop-specific differences.

## What's included

### Shell setup

- `.bash_profile` loads `.bashrc` for login shells.
- `.bashrc` sets a colored shell environment, initializes the Starship prompt, adds `~/.local/bin` to `PATH`, and defines a `dot` alias for managing this bare dotfiles repo.
- `.config/fish/config.fish` provides the same basic shell workflow for Fish, including aliases, `PATH` setup, Starship integration, and custom Win95-style colors.
- `.config/fish/functions/fish_prompt.fish` contains a custom Fish prompt function.
- `.config/starship.toml` defines a minimal prompt that shows the current directory and Git status.

### Window manager and desktop

- `.config/hypr/hyprland.conf` is the main Hyprland configuration. It defines monitor layouts, startup apps, keybinds, gestures, window rules, floating behavior, screenshot shortcuts, media keys, brightness keys, and a Win95-inspired title bar/border theme.
- `.config/hypr/env_var.conf` stores additional environment variables used by the Hyprland session.
- `.config/hypr/hyprlock.conf` configures the lock screen.
- `.config/hypr/xdg-portal-hyprland` sets up the Hyprland XDG portal startup behavior.
- `.config/mako` contains notification daemon settings.
- `.config/wofi` contains launcher styling and behavior.
- `.config/wlogout` contains logout menu styling and actions.

### Waybar

- `.config/waybar/config` defines the laptop status bar layout and modules, including workspaces, clock, audio, battery, backlight, media info, mic state, refresh rate, and package update count.
- `.config/waybar/style.css` is the active Waybar theme.
- `.config/waybar/scripts/asus_profile.sh` shows the active ASUS performance profile in Waybar.
- `.config/waybar/scripts/bluetooth_status.sh` reports Bluetooth status for the bar.
- `.config/waybar/scripts/gfx_status.sh` shows the current graphics mode from `supergfxctl`.
- `.config/waybar/scripts/mic_status.sh` shows whether the microphone is muted.
- `.config/waybar/scripts/refresh_rate.sh` displays the current laptop panel refresh rate.

### Custom scripts

- `.scripts/brightness.sh` increases or decreases brightness using `brightnessctl` and sends a desktop notification with the current brightness percentage.
- `.config/hypr/scripts/brightness_ctl.sh` provides Hyprland-side brightness control automation.
- `.config/hypr/scripts/volume_ctl.sh` handles volume changes with desktop feedback.
- `.config/hypr/scripts/refresh-toggle.sh` toggles the built-in display between 60Hz and 144Hz and sends a notification.
- `.config/hypr/scripts/caffeine.sh` is used to toggle a keep-awake / caffeine-style behavior.
- `.config/hypr/scripts/lock.sh` locks the session.
- `.config/hypr/scripts/lock_on_sleep.sh` locks the session when the machine is going to sleep.
- `.config/hypr/scripts/logout.sh` handles logout actions.
- `.config/hypr/scripts/sleep.sh` triggers suspend behavior.
- `.config/hypr/scripts/switch_kb_layout.sh` switches keyboard layouts.
- `.config/hypr/scripts/toggle_bluetooth.sh` toggles Bluetooth.

### Editor and terminal

- `.config/nvim/init.lua` bootstraps the Neovim setup, loads core configuration, optional custom overrides, key mappings, and plugins via `lazy.nvim`.
- `.config/kitty` contains terminal emulator configuration.
- `.config/zathura` contains PDF viewer preferences.

### Appearance and theming

- `.gtkrc-2.0`, `.config/gtk-3.0`, and `.config/gtk-4.0` contain GTK theme settings.
- `.config/fontconfig` contains font rendering configuration.
- `.config/brave-flags.conf`, `.config/code-flags.conf`, and `.config/cursor-flags.conf` store Wayland and app launch flags for Brave, VS Code, and Cursor.

### Utilities and app configs

- `.config/btop`, `.config/htop`, and `.config/neofetch` store terminal utility preferences.
- `.config/easyeffects` contains audio effect presets.
- `.config/rog` contains ASUS ROG-specific configuration.
- `.config/sunshine` contains Sunshine streaming configuration.
- `.config/mimeapps.list` defines default application associations.
- `.config/user-dirs.dirs` defines XDG user directory locations.
- `.gitconfig` contains personal Git settings.
- `.gitignore` excludes local machine-specific files from the repo.

### System-specific extras

- `.local/share/system-configs/install.sh` installs supporting systemd sleep/resume services and reminds you to add the correct resume kernel parameters manually.
- `.local/share/system-configs/etc` and `.local/share/system-configs/boot` store extra machine-level config files that complement the user dotfiles.

## Installation

Because this is a bare dotfiles repository, a common way to install it is to check it out into your home directory using a Git alias:

```sh
git clone --bare https://github.com/zoobavitel/Dotfiles-Laptop- "$HOME/.dotfiles"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles checkout
```

If `checkout` reports conflicts, back up the conflicting files first and then run the command again.

You may also want to hide untracked files in status output:

```sh
dotfiles config --local status.showUntrackedFiles no
```

## Notes

- Designed for my laptop environment
- Nearly identical to my desktop dotfiles
- Meant for personal use, but feel free to adapt anything useful
