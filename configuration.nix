{ config, pkgs, ... }:

{

  environment = {

    systemPackages = with pkgs; [ bash fish zsh ];
    shells = with pkgs; [ bash fish zsh ];

    etc = {
     "sudoers.d/10-nix-commands".text = ''
       george ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/nix*, \
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

  programs.bash.enable = true;
  programs.zsh.enable = true;

}
