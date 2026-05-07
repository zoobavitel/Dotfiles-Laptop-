# Dotfiles for my laptop

Hi! These are the dotfiles I use on my laptop.

## Overview

This repository contains my personal configuration files for a laptop setup. It includes:

- **Lua** configs, likely for editor or window manager customization
- **CSS** styles for theming and appearance tweaks
- **Shell** configuration and utility scripts

It is kept very close to my desktop setup, with only small laptop-specific differences.

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
