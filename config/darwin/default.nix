{ pkgs, config, ... }:

{
  # TODO: Use builtins to read all files in the directory.
  imports = [
    ./homebrew.nix
    ./preferences.nix
    ./security.nix
  ];

  environment = {
    darwinConfig = "$HOME/.nixpkgs/configuration.nix";
  };

  services.nix-daemon.enable = true;

  networking = {
    computerName = "cover-macbookpro";
    localHostName = "cover-macbookpro";
    hostName = "cover-macbookpro";
  };

  system.stateVersion = 4;
}