{ pkgs, lib, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  environment.systemPackages = with pkgs; [ home-manager ];
  home-manager = {
    useGlobalPkgs = true;
  };

}
