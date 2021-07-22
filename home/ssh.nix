{ pkgs, lib, ... }:

let
  inherit (lib) optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;
  home = builtins.getEnv "HOME";

in {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "GitHub" = {
        hostname = "github.com";
        user = "github@georgecover.email";
        identityFile = "${home}/.ssh/github_rsa";
      };

      "BitBucket" = {
        hostname = "bitbucket.org";
        user = "georgecoverpythian";
        identityFile = "${home}/.ssh/cover-tehama";
      };
    };

    extraOptionOverrides = {
      Include = "./config.local";
    };
    
    #TODO: Is UseKeychain doing anything at all now?
    extraConfig = ''
      IgnoreUnknown UseKeychain
      UseKeychain yes
      AddKeysToAgent yes
    '';
  };
}