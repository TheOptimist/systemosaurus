{ pkgs, config, lib, ... }:

let
  inherit (lib) mkMerge mkIf optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

  # Kitty terminfo is added for shell from .app resource, but tput doesn't find it
  kitty-terminfo = with pkgs; stdenv.mkDerivation rec {
    name = "kitty-terminfo";
    src = fetchFromGitHub {
      owner = "kovidgoyal";
      repo = "kitty";
      rev = "e6644aebcbca9176b3ca0144b5875848ca50b4d0";
      sha256 = "0w9a54ivg95v9lwpf0zw8xl4bg06k6xx6l0kj90zmqf9g7b5vr5s";
    };
    dontConfigure = true;
    dontPatch = true;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out
      cp ${src}/terminfo/kitty.terminfo $out
    '';
  };

in 
  mkMerge [
    {
      environment.systemPackages = with pkgs; flatten [
        tmux
        
        (optional isLinux kitty)

        (optional isDarwin kitty-terminfo)
        (optional isDarwin reattach-to-user-namespace)
      ];
    }
  
    (mkIf isDarwin {
      homebrew.casks = [ "kitty" ];
      system.activationScripts.postActivation.text = ''
        tic -xe xterm-kitty ${kitty-terminfo.outPath}/kitty.terminfo
        sudo tic -xe xterm-kitty ${kitty-terminfo.outPath}/kitty.terminfo
      '';
    })
  ]