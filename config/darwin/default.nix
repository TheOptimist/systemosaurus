# TODO: Use builtins to read all files in the directory.
{ pkgs, config, ... }:

{
  imports = [
    ./homebrew.nix
    ./preferences.nix
  ];
  
  environment = {
    darwinConfig = "$HOME/.nixpkgs/configuration.nix";
  };

  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flake";

    maxJobs = 4;
    buildCores = 4;
  };

  # Add ability to used TouchID for sudo authentication (custom module)
  security.pam.enableSudoTouchIdAuth = true;
  system.activationScripts.extraActivation.text = config.system.activationScripts.pam.text;

  system.stateVersion = 4;
}