{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    exa
    tree
  ];

}
