# TODO: Use builtins to read all files in the directory.
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
    procs

    tmux
    reattach-to-user-namespace
    
    bat
    exa
    imgcat
    jq

    lastpass-cli
    awscli2

    asciinema
    asciinema-scenario
    asciigraph
  ];

}
