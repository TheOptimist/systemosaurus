{ pkgs, lib, ... }:

let
  inherit (lib) mkMerge optionalAttrs;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

in 

  mkMerge [
    {
      # overkill and I'm not using them, but I want to try fish at some point
      environment = {
        systemPackages = with pkgs; [ bash fish zsh ];
      };

      programs.zsh.enable = true;
      programs.bash.enable = true;
      programs.fish.enable = true;
    }

    (optionalAttrs isDarwin {
      environment.shells = with pkgs; [ bash fish zsh ];
    })

    (optionalAttrs isLinux {
      users.defaultUserShell = pkgs.zsh;
    })
  ] 
