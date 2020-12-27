{ config, pkgs, ... }:

{

  imports = [ 
    ../configuration.nix
    <home-manager/nix-darwin>
    ./preferences.nix
  ];

  environment = {

    darwinConfig = "$HOME/.nixpkgs/darwin/configuration.nix";

    etc = {
     "sudoers.d/20-nix-darwin".text = ''
       george ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/darwin-rebuild
      '';
    };
  };

  users.users.george.home = "/Users/george";
  home-manager.useUserPackages = true;
  home-manager.users.george = import ./home.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;

}
