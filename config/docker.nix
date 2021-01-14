{ pkgs, lib, ... }:

let
  inherit (lib) mkMerge mkIf optional;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

  homeDirectory = builtins.getEnv "HOME";
  xdgConfigHome = "${homeDirectory}/.config";
  
in 
  mkMerge [
    # This is guess right now. Haven't attempted a linux install yet.
    (mkIf isLinux {
      environment = {
        systemPackages = with pkgs; [
          docker
          docker-machine
          docker-compose
        ];

        variables = {
          DOCKER_CONFIG = "${xdgConfigHome}/docker";
          MACHINE_STORAGE_PATH = "${xdgConfigHome}/docker/machine";
        };
      };
    })
    
    # TODO: Move away from Homebrew Docker to unify linux and darwin machine configurations
    # Homebrew has all the same packages, which theoretically means I could use the same pattern
    # Linux mechanic above not tested yet either, so no doubt change is a-coming
    (mkIf isDarwin {
      homebrew.casks = [ "docker" ];
    })
    # TODO: Launch Docker on startup?
  ]
  