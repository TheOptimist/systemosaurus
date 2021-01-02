# TODO: Use builtins to read all files in the directory.
# TODO: Create a darwin directory for specific home configuration?
{ pkgs, lib, ... }:

let
  inherit (lib) optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;
in  {

  imports = flatten [
    ./fonts.nix
    ./shell.nix
    ./vscode.nix
    ./home-manager.nix
    (optional isDarwin ./darwin)
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flake";

    maxJobs = 4;
    buildCores = 4;
  };

  environment.systemPackages = with pkgs; [
    alacritty
    tmux
    reattach-to-user-namespace
    
    asciinema
    asciinema-scenario
    asciigraph

    bat
    exa
    imgcat

    lastpass-cli
    #awscli2 # Try out whalebrew first?
  ];

}
