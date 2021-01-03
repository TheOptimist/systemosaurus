{ ... }:

{
  # See https://github.com/LnL7/nix-darwin/tree/master/modules/system/defaults
  system.defaults = {

    # See https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/NSGlobalDomain.nix
    NSGlobalDomain = {
      # Whether to use the metric system. Default is based on region settings.
      AppleMetricUnits = 1;
      # Whether to use centimeters or inches. Default is based on region settings.
      AppleMeasurementUnits = "Centimeters";
      # Whether to use Celsius or Farenheit. Default is based on region settings.
      AppleTemperatureUnit = "Celsius";

      # Whether to enable automatic capitalization. Default is true.
      NSAutomaticCapitalizationEnabled = false;
      # Whether to enable smart dash substitution. Default is true.
      NSAutomaticDashSubstitutionEnabled = false;
      # Wehther to enable smart period substitution. Default is true.
      NSAutomaticPeriodSubstitutionEnabled = false;
      # Whether to enable smart quote substitution. Default is true.
      NSAutomaticQuoteSubstitutionEnabled = false;
      # Whether to enable automatic spelling correction. Default is true.
      NSAutomaticSpellingCorrectionEnabled = false;

      # Sets the size of the finder sidebar icons: 1 (small), 2 (medium), or 3 (large). Default is 3.
      NSTableViewDefaultSizeMode = 1;

      # Configures the trackpad tab behavior. Mode 1 enables tap to click.
      "com.apple.mouse.tapBehavior" = 1;
    };

    # See https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/loginwindow.nix
    loginwindow = {
      GuestEnabled = false;
    };

    # See https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/dock.nix
    dock = {
      # Whether to automatically hide and show the Dock. Default is false.
      autohide = true;
      # Sets the speed of the autohide delay. Default is "0.24".
      autohide-delay = "0.0";
      # Sets the speed of animation when hiding/showing the Dock. Default is "1.0".
      autohide-time-modifier = "1.0";
      # Position of dock. Default is "bottom"; alternatives are "left" and "right".
      orientation = "left";
      # Whether to make icons of hidden applications translucent. Default is false.
      showhidden = true;
      # Show recent applications in the dock. Default is true.
      show-recents = false;
      # Show only open applications in the Dock. Default is false.
      static-only = true;
      # Size of the icons in the Dock. Default is 64.
      tilesize = 32;
    };

    # See https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/finder.nix
    finder = {
      # Whether to always show file extensions. Default is false.
      AppleShowAllExtensions = true;
      # Whether to show warnings when changing file extensions. Default is true.
      FXEnableExtensionChangeWarning = false;
    };

    # See https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/trackpad.nix
    trackpad = {
      # Whether to enable trackpad tap to click. Default is false.
      Clicking = true;
      # Whether to enable trackpad right click. Default is false.
      TrackpadRightClick = true;
    };
  };

  # Found at https://superuser.com/questions/1420107/how-can-i-toggle-handoff-continuity-in-terminal-on-macos
  system.activationScripts.extraUserActivation.text = ''
    defaults -currentHost write com.apple.coreservices.useractivityd ActivityAdvertisingAllowed -bool no
    defaults -currentHost write com.apple.coreservices.useractivityd ActivityReceivingAllowed -bool no
  '';
}

