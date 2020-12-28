{ lib, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  home-manager = {
    useGlobalPkgs = true;
  };

}
