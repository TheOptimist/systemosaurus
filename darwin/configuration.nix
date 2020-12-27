{ config, pkgs, ... }:

{
  environment = {

    systemPackages = with pkgs; [ bash fish zsh ];
    darwinConfig = "$HOME/.nixpkgs/darwin/configuration.nix";
    shells = with pkgs; [ bash fish zsh ];

    etc = {
     "sudoers.d/10-nix-commands".text = ''
       george ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/darwin-rebuild, \
                                      /run/current-system/sw/bin/nix*, \
                                      /run/current-system/sw/bin/ln, \
                                      /run/store/*/activate, \
                                      /bin/launchctl
      '';
    };
  };

  services.nix-daemon.enable = true;

  programs.bash.enable = true;
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;
}
