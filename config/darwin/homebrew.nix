{ config, ... }:

{
  system.activationScripts.extraUserActivation.text = config.system.activationScripts.homebrew.text;

  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
  ];

  homebrew.casks = [
    "alfred"

    "lastpass"

    "firefox"
    "google-chrome"
    "microsoft-edge"
    
    "signal"
    "skype"
    "slack"
    "spark"
    "whatsapp"

    "rekordbox"
  ];
}