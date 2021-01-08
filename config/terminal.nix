{ pkgs, lib, ... }:

let
  inherit (lib) optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

  kittyTerminfoUrl = "https://raw.githubusercontent.com/kovidgoyal/kitty/master/terminfo/kitty.terminfo";
  kittyTerminfo = builtins.fetchurl kittyTerminfoUrl;

in {

  environment.systemPackages = with pkgs; [ 
    kitty
    tmux
    reattach-to-user-namespace
  ];

  # Installing Kitty via system packages on Darwin means Alfred launcher can't find it
  # TODO: Fix Alfred metadata, or create a workflow, so I can launch with Clover+Space
  # homebrew.casks = flatten [
  #   (optional isDarwin "kitty")
  # ];

  #TODO: Add terminfo to system
  
  # kittyTerminfo  
  # config = {
  #   system.activationScripts.extraUserActivation.text = ''
  #     kittyTmpDir="$(mktemp -d -t kitty)"
  #   '';
  # };

  # };
    # if [ ! $( infocmp xterm-kitty &>/dev/null) ]; then
    #     kittyDir=$(mktemp -d -t kitty)
    #     git clone --depth 1 "${kittyRepo}" "$kittyDir"
    #     sudo tic -xe xterm-kitty $kittyDir/terminfo/kitty.terminfo
    #   fi

    #   echo "Removing themes at ${themesPath}"
    #   rm -rf "${themesPath}";
    #   echo "Cloning repository at ${themesRpo}"
    #   git clone --depth 1 ${themesRepo} ${themesPath}

    #   if [ ! -f "${kittyConfig}/theme.conf" ]; then
    #     ln -s "${themesPath}/${defaultTheme}" "${kittyConfig}/theme.conf"
    #   fi
}