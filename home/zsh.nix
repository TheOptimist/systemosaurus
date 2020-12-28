{ pkgs, ... }:

let
  # TODO: Should not have to do this. Home-Manager has these XDG values somewhere.
  homeDirectory = builtins.getEnv "HOME";
  xdgConfigHome = ".config";

in rec {
  programs.zsh = {
    enable = true;
#    enableAutoSuggestions = true;
#    enableCompletion = true;

    dotDir = "${xdgConfigHome}/zsh";

#    history = {
#      size = 5000;
#      save = 50000;
#      path = "${dotDir}/history";
#      ignoreDups = true;
#    };

    shellAliases = {
      ls = "exa -l";
      la = "exa -la";
      lt = "exa -l --tree";
    };

    sessionVariables = {
      ZDOTDIR = "${xdgConfigHome}/zsh";
    };

    # TODO: Work out how to get PowerLevel10k into zsh and xdg config
    # plugins = [
    #   {
    #     name = "powerlevel10k";
    #     src = pkgs.zsh-powerlevel10k;
    #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #   }
    # ];
  };

}
