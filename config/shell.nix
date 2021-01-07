{ pkgs, lib, ... }:

let
  inherit (lib) mkMerge mkForce optionalAttrs;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

  xdgConfigHome = builtins.getEnv "XDG_CONFIG_HOME";
  xdgDataHome = builtins.getEnv "$XDG_DATA_HOME";
in 

  mkMerge [
    {
      environment = {
        systemPackages = with pkgs; [ bash fish zsh ];

        variables = {
          DOCKER_CONFIG = "${xdgConfigHome}/docker";
          TERMINFO="${xdgDataHome}/terminfo";
          TERMINFO_DIRS="${xdgDataHome}/terminfo:usr/share/terminfo";
        };
      };

      programs.zsh = {
        enable = true;
        # Prevent NixOS from clobbering prompts
        # See: https://github.com/NixOS/nixpkgs/pull/38535
        promptInit = lib.mkDefault "";
      };

      programs.bash.enable = true;
    }

    (optionalAttrs isDarwin {
      environment.shells = with pkgs; [ bash fish zsh ];
    })

    (optionalAttrs isLinux {
      users.defaultUserShell = pkgs.zsh;
    })
  ] 
