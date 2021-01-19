{ pkgs, config, lib, ... }:

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

  theme     = "OneDark";
  batTheme = "TwoDark"; # Why not make it the same :(

in {

  xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;
  xdg.configFile."kitty/theme.conf".text = "include ${kitty-themes.outPath}/${theme}.conf";
  
  home = {
    sessionVariables = {
      TERMINFO_DIRS = "${config.xdg.dataHome}/terminfo:/usr/share/terminfo";
      BAT_THEME="${batTheme}";
    };
  };
}