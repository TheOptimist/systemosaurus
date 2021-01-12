{ pkgs, lib, config, ... }:

with lib;
let
  kitty-themes = with pkgs; stdenv.mkDerivation rec {  
    name = "kitty-themes";
    src = fetchFromGitHub {
      owner = "theoptimist";
      repo = "kitty-themes";
      rev = "fca3335489bdbab4cce150cb440d3559ff5400e2";
      sha256 = "11dgrf2kqj79hyxhvs31zl4qbi3dz4y7gfwlqyhi4ii729by86qc";
    };
    installPhase = ''
      mkdir -p $out
      cp ${src}/themes/* $out/
    '';
  };

  theme  = "OneDark";

in {

  xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;

  home.sessionVariables = {
    TERMINFO = "${config.xdg.dataHome}/terminfo";
    TERMINFO_DIRS = "${config.xdg.dataHome}/share/terminfo:/usr/share/terminfo";
  };

  xdg.configFile."kitty/theme.conf".text = "include ${kitty-themes.outPath}/${theme}.conf";

  # config = {
  #   system.activationScripts.extraUserActivation.text = ''
  #     echo "Woohoo"
  #   '';
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