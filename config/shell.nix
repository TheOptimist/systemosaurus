{ pkgs, lib, ... }:

let
  inherit (lib) mkMerge mkForce optionalAttrs;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;
in

  mkMerge [
    {
      environment = {
        systemPackages = with pkgs; [ bash fish zsh ];
        variables = {
          SHELL = "${pkgs.zsh}/bin/zsh";
          XDG_CONFIG_HOME = "$HOME/.config";
          XDG_CACHE_HOME = "$HOME/.cache";
          XDG_SHARE_HOME = "$HOME/.local/share";
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
