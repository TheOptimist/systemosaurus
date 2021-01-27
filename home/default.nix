{ pkgs, lib, ... }:

# TODO: Use builtins to read all files in the directory.
let
  inherit (lib) optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;
in {
  imports = flatten [
    ./cloud
    ./git.nix
    ./lastpass.nix
    ./shell
    ./ssh.nix
    ./terminal
    ./tmux
  ];

  xdg.enable = true;
}