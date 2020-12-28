{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nix-darwin>
    ./fonts.nix
    ./preferences.nix
  ];

  environment = {

    systemPackages = with pkgs; [ bash fish zsh ];
    shells = with pkgs; [ bash fish zsh ];

    darwinConfig = "$HOME/.nixpkgs/configuration.nix";

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
  # nix.package = pkgs.nixFlakes;
  nix.maxJobs = 4;
  nix.buildCores = 4;
  # nix.extraOptions = "experimental-features = nix-command flakes";

  users.users.george.home = "/Users/george";
  home-manager = {
    useUserPackages = true;
    users.george = import ./home-manager;
  };

  programs.bash.enable = true;
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;
}
