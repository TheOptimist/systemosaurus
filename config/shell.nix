{ pkgs, lib, ... }:

let
  inherit (lib) mkMerge mkForce optionalAttrs;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

  homeDirectory = builtins.getEnv "HOME";
  xdgConfigDirectory = "${homeDirectory}/.config";
in

  mkMerge [
    {
      environment = {
        systemPackages = with pkgs; [ bash fish zsh ];
        variables = {
          #ZDOTDIR = "\$XDG_CONFIG_HOME/zsh";

          # '$' signs need to be escaped to make it into the shell properly (might be able to use builtins getEnv?)
          # Ideally I'd be specifying this in home-manager, but can't make this work atm
          #LPASS_HOME = "${xdgConfigDirectory}/lpass";
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
