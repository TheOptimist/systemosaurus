# Systemosaurus
My (currently Darwin only) system configuration and setup using [Nix](https://nixos.org) and [Nix-Darwin](https://github.com/LnL7/nix-darwin).

## Installation
Yolo!
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/TheOptimist/systemosaurus/main/install)"
```
Not yet worked out how to change default shell for user (maybe with home manager), so...
```
chsh -s /run/current-system/sw/bin/zah
```

Instaling application from the App Store via `mas` will not work until you have signed into the App Store. Do that first.

## Goals
- [x] Installs Command Line Tools [silently](https://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line/195963#195963)  
- [x] Installs [Nix](https://nixos.org)    
- [x] Installs [Nix-Darwin](https://github.com/LnL7/nix-darwin)  
- [x] Installs [HomeBrew](https://brew.sh)    
- [x] Clones this repository to the local machine  
- [x] Initiates first `darwin-rebuild` to switch configurations  

#### Nix on Darwin
Installing with daemon for [multi-user](https://nixos.org/manual/nix/stable/#sect-multi-user-installation) despite there only being a single user on my Mac.

Using "[unencrypted volume](https://nixos.org/manual/nix/stable/#sect-macos-installation)" for MacOS.

#### Still using Homebrew?
Yep, some packages are only available via brew or [mas](https://github.com/mas-cli/mas).

## Layout
* `config/` - Package installation and configuration
* `home/` - Home-manager configuration and dotfile management
* `modules/` - Modules to assist configuration of machine
* `profiles/` - Configuration profiles (bit weak this one, it's fairly empty)

## Inspiration
Becaue I am far too early on in my journey with nix. Heavily inspired by:

* https://github.com/rummik/nixos-config
* https://github.com/kclejeune/system
* https://github.com/malob/nixpkgs
* https://github.com/lccambiaghi/nixpkgs
* https://github.com/kitten/nix-system
* https://github.com/lucperkins/nix-home-config
* https://btwiusegentoo.github.io/nixconfig/
## Future
Move to using flakes? Some of the repositories above seem to shorten the install
workflow to install nix, clone the repository and then darwin-rebuild, which would
be nice.