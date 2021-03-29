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

  services.lorri.enable = true;

  environment = {
    systemPackages = with pkgs; flatten [
      niv
      direnv

      procs
      
      bat
      curl
      exa
      imgcat
      less
      tmux

      go
      packer
      
      customGit
      httpie
      ipcalc
      jq
      lazygit

      lastpass-cli

      asciinema
      asciinema-scenario
      asciigraph

      (optional isLinux radicle-upstream)
    ];
  };

}
