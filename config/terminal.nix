{ pkgs, lib, ... }:

let
  inherit (lib) optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

  # Kitty terminfo is added when using nixbut not via brew :(
  # kitty-terminfo = with pkgs; stdenv.mkDerivation rec {
  #   name = "kitty-terminfo";
  #   # src = fetchurl {
  #   #   url = "https://raw.githubusercontent.com/TheOptimist/kitty/master/terminfo/kitty.terminfo";
  #   #   sha256 = "1qm07vibnlvwifdxd48xg7szcpf20swxx2wjsdgnkn5779qik8pn";
  #   # };
  #   src = fetchFromGitHub {
  #     owner = "kovidgoyal";
  #     repo = "kitty";
  #     rev = "edfc6903ceaa03d5bc763259a97a2b515d15d7ff";
  #     sha256 = "1bb2q2j3vx3a27iag3qpynpc4w97a11whwiiwgl682l5myb9398k";
  #   };
  #   buildInputs = [ ncurses ];
  #   dontConfigure = true;
  #   #dontUnpack = true;
  #   dontPatch = true;
  #   dontBuild = true;
  #   installPhase = ''
  #     mkdir -p $out
  #     cp ${src}/terminfo/kitty.terminfo $out
  #     tic -xe xterm-kitty $out/kitty.terminfo
  #   '';
  # };

  

in {

  environment.systemPackages = with pkgs; flatten [
    kitty
    #kitty-terminfo
    tmux
    (optional isDarwin reattach-to-user-namespace)
  ];
  
  # TODO: Fix Alfred metadata, or create a workflow, so I can launch more easily
  # Perhaps SKHD may solve a single app...maybe GUI apps should just be installed by homebrew
  # homebrew.casks = flatten [
  #   (optional isDarwin "kitty")
  # ];

}