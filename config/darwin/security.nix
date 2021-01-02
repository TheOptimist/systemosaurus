{config, ... }:

{
  # Add ability to use TouchID for sudo authentication (custom module)
  security.pam.useTouchIdForSudo.enable = true;

  # Have to reattach to session namespace so TouchID works inside tmux
  security.pam.reattachToSessionNamespace.enable = true;

  # In order to use pam_reattach (above) we need a brew
  homebrew.taps = [ "fabianishere/personal" ];
  homebrew.brews = [ "fabianishere/personal/pam_reattach" ];
 
  system.activationScripts.extraActivation.text = config.system.activationScripts.pam.text;

  environment.etc = {
    "sudoers.d/10-nix-commands".text = ''
      george ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/darwin-rebuild, \
                                     /run/current-system/sw/bin/nix*, \
                                     /run/current-system/sw/bin/ln, \
                                     /nix/store/*/activate, \
                                     /bin/launchctl
    '';
  };
}