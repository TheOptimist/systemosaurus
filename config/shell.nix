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
