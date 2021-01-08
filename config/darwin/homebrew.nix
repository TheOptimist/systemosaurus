{ config, ... }:

{
  system.activationScripts.extraUserActivation.text = config.system.activationScripts.homebrew.text;

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";

    taps = [
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/core"
      "homebrew/services"
    ];

    brews = [
      "mas"
    ];

    casks = [
      "alfred"
      "ubersicht"

      "firefox"
      "google-chrome"
      "microsoft-edge"
      
      "amazon-chime"
      "signal"
      "skype"
      "slack"
      "whatsapp"
      "zoom"
      
      "spotify"
      "rekordbox"
    ];

    masApps = {
      Spark = 1176895641;
      Magnet = 441258766;
    };
  };
}