{ pkgs, config, lib, ... }:

let
  inherit (lib) mkMerge mkIf optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

in 
  mkMerge [
    {
      environment.systemPackages = with pkgs; flatten [
        (optional isLinux kitty)        
        tmux
        (optional isDarwin reattach-to-user-namespace)
      ];
    }
  
    # TODO: Fix Alfred metadata, or create a workflow, so I can launch more easily
    # Perhaps SKHD may solve a single app...maybe GUI apps should just be installed by homebrew
    (mkIf isDarwin {
      homebrew.casks = [ "kitty" ];
    })
  ]