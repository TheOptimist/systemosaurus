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

  system.stateVersion = 4;
}