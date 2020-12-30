{ pkgs, config, ... }:

{
  # TODO: Use builtins to read all files in the directory.
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

  # Add ability to use TouchID for sudo authentication (custom module)
  security.pam.useTouchIdForSudo.enable = true;
  security.pam.reattachToSessionNamespace.enable = true;
  # In order to use pam_reattach (above) we need a brew
  # TODO: Create link between module and brew? Create nix-darwin package?
  homebrew.taps = [ "fabianishere/personal" ];
  homebrew.brews = [ "fabianishere/personal/pam_reattach" ];
  system.activationScripts.extraActivation.text = config.system.activationScripts.pam.text;

  system.stateVersion = 4;
}