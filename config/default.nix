# TODO: Use builtins to read all files in the directory.
{ pkgs, config, lib, ... }:

let
  inherit (lib) optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

  customGit = pkgs.buildEnv {
    name = "git";
    paths = with pkgs.gitAndTools; [
      git
      delta    # Better diff presentation
      gh       # GitHub CLI tool
    ];
  };

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

    maxJobs = 8;
    buildCores = 4;
  };

  environment = {
    systemPackages = with pkgs; [
      procs

      tmux
      reattach-to-user-namespace
      
      bat
      exa
      imgcat
      jq

      customGit

      lastpass-cli
      awscli2

      asciinema
      asciinema-scenario
      asciigraph
    ];
  };

}
