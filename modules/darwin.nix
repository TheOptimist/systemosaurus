{ pkgs, options, ... }:

{

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

  system.stateVersion = 4;
}
