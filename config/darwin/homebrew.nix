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
      
      "audio-hijack"
      "spotify"
      "rekordbox"

      "parallels"

      "radicle-upstream"
    ];

    masApps = {
      Spark = 1176895641;
      Magnet = 441258766;
    };
  };

  # After installing an app via Homebrew, remove the quarantine flag
  # It would be great if I understood this more. Opening the app anyway
  # doesn't seem to remove the quarantine flag...so what's happening?
  system.activationScripts.extraUserActivation.text = ''
    ${config.system.activationScripts.homebrew.text}

    echo >&2 "removing quarantine flags..."
    find /Applications -xattrname com.apple.quarantine \
      | while read file; do \
          sudo xattr -r -d com.apple.quarantine "$file"; \
        done
  '';

}