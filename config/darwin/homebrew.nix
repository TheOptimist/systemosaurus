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
    "firefox"
    "google-chrome"
    "lastpass"
    "signal"
    "slack"
  ];
}