# Systemosaurus
My (currently Darwin only) system configuration and setup using [Nix](https://nixos.org) and [Nix-Darwin](https://github.com/LnL7/nix-darwin).

Heavily inspired by [rummik's nix configuration](https://github.com/rummik/nixos-config) (very heavily).

## Installation
Yolo!
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/TheOptimist/systemosaurus/main/install)"
```

## Goals
[ ] Installs Command Line Tools [silently](https://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line/195963#195963)  
[ ] Installs [Nix](https://nixos.org)    
[ ] Installs [Nix-Darwin](https://github.com/LnL7/nix-darwin)  
[ ] Installs [HomeBrew](https://brew.sh)    
[ ] Clones this repository to the local machine  
[ ] Initiates first `darwin-rebuild` to switch configurations  

### Nix on Darwin
Installing with daemon for [multi-user](https://nixos.org/manual/nix/stable/#sect-multi-user-installation) despite there only being a single user on my Mac.

Using "[unencrypted volume](https://nixos.org/manual/nix/stable/#sect-macos-installation)" for MacOS.

### Still using Homebrew?
Yep, some packages are only available via brew or [mas](https://github.com/mas-cli/mas).