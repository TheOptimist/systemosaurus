{ config, ... }:

{
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
      "defaultbrowser"
      "mas"
      "oci-cli"
    ];

    casks = [
      "alfred"
      "ubersicht"

      "firefox"
      "google-chrome"
      "microsoft-edge"
      
      "amazon-chime"
      "microsoft-teams"
      "signal"
      "skype"
      "slack"
      "webex"
      "whatsapp"
      "zoom"
      
      "audio-hijack"
      "spotify"
      "rekordbox"

      "parallels"

      "radicle-upstream"
      "virtualbox"
    ];

    masApps = {
      Spark        = 1176895641;
      Magnet       = 441258766;
      Pages        = 409201541;
      MicrosoftRDP = 1295203466;
    };
  };

  system.activationScripts.extraUserActivation.text = ''
    ${config.system.activationScripts.homebrew.text}
  '';

}