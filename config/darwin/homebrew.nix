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

      "lastpass"

      "firefox"
      "google-chrome"
      "microsoft-edge"
      
      "signal"
      "skype"
      "slack"
      "whatsapp"

      "rekordbox"
    ];

    masApps = {
      Spark = 1176895641;
    };
  };
}