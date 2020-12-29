{ pkgs, lib, ... }:

let
  inherit (lib) optionalAttrs mkMerge mkIf mkDefault;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;
in
  mkMerge [
    {
      users.users.george.home = mkIf isDarwin "/Users/george";
      home-manager.users.george = (import ../home);
    }
  
    (optionalAttrs isLinux {
      users.users.george = {
        isNormalUser = true;
        home = "/home/george";
      };
    })
  ]