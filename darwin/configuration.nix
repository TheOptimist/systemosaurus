{ config, pkgs, ... }:

{
  environment = {

    systemPackages = with pkgs; [ bash fish zsh ];
    darwinConfig = "$HOME/.nixpkgs/darwin/configuration.nix";
    shells = with pkgs; [ bash fish zsh ];
  }

  services.nix-daemon.enable = true;

  programs.bashe.enable = true;
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;
}
