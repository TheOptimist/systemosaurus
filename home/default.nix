{ pkgs, lib, ... }:

# TODO: Use builtins to read all files in the directory.
let
  inherit (lib) optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;
in {
  imports = flatten [
    ./cloud.nix
    ./git.nix
    ./lastpass.nix
    ./shell
    ./terminal
    ./tmux
  ];

  xdg.enable = true;
}