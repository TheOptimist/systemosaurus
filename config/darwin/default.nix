{ pkgs, config, ... }:

{
  # TODO: Use builtins to read all files in the directory.
  imports = [
    ./homebrew.nix
    ./preferences.nix
    ./security.nix
  ];

  environment = {
    darwinConfig = "$HOME/.config/nixpkgs/configuration.nix";
  };

  services.nix-daemon.enable = true;

  networking = {
    computerName = "cover-macbookpro";
    localHostName = "cover-macbookpro";
    hostName = "cover-macbookpro";
  };

  # Disable quarantine for downloaded applications
  # Still umming about this one...
  system.defaults.LaunchServices.LSQuarantine = false;
  system.stateVersion = 4;
}