{ pkgs, lib, ... }:

with lib;

let 
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

in {
  programs.git = {
    enable = true;

    userName = "George Cover";
    userEmail = "5285515+TheOptimist@users.noreply.github.com";
    

    signing = {
      key = "D39BD3823FE4EBCA";
      signByDefault = true;
      # Yep, only works on Mac right now...
      gpgPath = "/usr/local/bin/gpg";
    };

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };

    ignores = flatten [
      (optional isDarwin ".DS_Store")
    ];

    aliases = {
      l = "log --graph --abbrev-commit --decorate --format=format:'%C(blue)%h%C(reset) - %C(green)(%ar)%C(reset) %s %C(italic)- %an%C(reset)%C(magenta bold)%d%C(reset)' --all";
    };
    
    package = pkgs.buildEnv {
      name = "customGit";
      paths = with pkgs.gitAndTools; [
        git
        delta    # Better diff presentation
        gh       # GitHub CLI tool
      ];
    };

    delta = {
      enable = true;
      options = {
        side-by-side = true;
        syntax-theme = "TwoDark";
      };
    };
  };
}    
