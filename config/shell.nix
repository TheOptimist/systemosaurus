{ pkgs, lib, ... }:

let
  inherit (lib) mkMerge mkForce optionalAttrs;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

in 

  mkMerge [
    {
      environment = {
        systemPackages = with pkgs; [ bash fish zsh ];
      };

      programs.zsh.enable = true;
      programs.bash.enable = true;
    }

    (optionalAttrs isDarwin {
      environment.shells = with pkgs; [ bash fish zsh ];
    })

    (optionalAttrs isLinux {
      users.defaultUserShell = pkgs.zsh;
    })
  ] 
