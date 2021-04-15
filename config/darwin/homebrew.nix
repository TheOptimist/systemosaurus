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
      "railwaycat/emacsmacport"
    ];

    brews = [
      "defaultbrowser"
      "gpg"
      "graphviz"
      "librsvg"
      "pinentry-mac"
      "mas"
      "oci-cli"
    ];

    casks = [
      "alfred"
      "monitorcontrol"
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

      "meld"
      "microsoft-remote-desktop"
      "radicle-upstream"
      "virtualbox"
    ];

    masApps = {
      Spark        = 1176895641;
      Magnet       = 441258766;
      Pages        = 409201541;
      Amphetamine  = 937984704;
    };

    extraConfig = ''
      brew "emacs-mac", args: [ "with-modules", "with-mac-metal" ]
    '';
  };

  system.activationScripts.extraUserActivation.text = ''
    ${config.system.activationScripts.homebrew.text}
  '';

}