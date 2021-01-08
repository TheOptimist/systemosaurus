{ pkgs, lib, ... }:

let
  xdgConfigPath = builtins.getenv "XDG_CONFIG_HOME";
  kittyConfig   = "${xdgConfigPath}/kitty";
  kittyRepo     = "https://github.com/kovidgoyal/kitty.git";
  themesPath    = "${kittyConfig}/themes";
  themesRepo    = "https://github.com/dexpota/kitty-themes.git";
  defaultTheme  = "OneDark";

in {

  xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;

  # home.sessionVariables = {
  #   TERMINFO = "$XDG_DATA_HOME/terminfo";
  #   TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo:/usr/share/terminfo";
  # };


  # kitty-themes = with lib; trivialBuild {
  #   pname = "kitty-themes";
  #   version = "1.0.0";
  #   src = pkgs.fetchFromGithub {
  #     owner = "";
  #     repo = "";
  #     rev = "";
  #     sha256 = "0z2n3h5l5fj8wl8i1ilfzv11l3zba14sgph6gz7dx7q12cnp9j22";
  #   };
  # };
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