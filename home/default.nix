{ pkgs, lib, ... }:

# TODO: Use builtins to read all files in the directory.
let
  inherit (lib) optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;
in {
  imports = flatten [
    ./git.nix
    ./terminal
    ./tmux
    ./zsh
  ];

  xdg.enable = true;
}