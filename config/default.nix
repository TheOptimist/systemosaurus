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
    ./docker.nix
    ./fonts.nix
    ./shell.nix
    ./terminal.nix
    ./vscode.nix
    ./home-manager.nix
    (optional isDarwin ./darwin)
  ];

  nix = {
    package = pkgs.nix;
    #extraOptions = "experimental-features = nix-command flakes";

    maxJobs = 8;
    buildCores = 4;
  };

  environment = {
    systemPackages = with pkgs; flatten [
      procs
      
      bat
      exa
      imgcat
      jq
      less

      customGit
      lazygit

      lastpass-cli

      asciinema
      asciinema-scenario
      asciigraph

      (optional isLinux radicle-upstream)
    ];
  };

}
