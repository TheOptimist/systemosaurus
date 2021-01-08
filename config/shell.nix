{ pkgs, lib, ... }:

let
  inherit (lib) mkMerge mkForce optionalAttrs;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

  homeDirectory = builtins.getEnv "HOME";
  xdgConfigHome = "${homeDirectory}/.config";
  xdgDataHome = "${homeDirectory}/.local/share";
in 

  mkMerge [
    {
      environment = {
        systemPackages = with pkgs; [ bash fish zsh ];

        variables = {
          TERMINFO = "${xdgDataHome}/terminfo";
          TERMINFO_DIRS = "${xdgDataHome}/terminfo:usr/share/terminfo";
        };
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
