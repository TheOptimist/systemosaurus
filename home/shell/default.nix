{ pkgs, lib, config, ... }:

rec {
  programs.zsh = {
    enable = true;
    # TODO: These aren't recognised ??
#    enableAutoSuggestions = true;
#    enableCompletion = true;

    # Frustratingly this has to be relative to $HOME
    # Be nicer if I didn't have to hardcode the XDG config directory
    dotDir = ".config/zsh";

    history = {
      size = 5000;
      save = 50000;
      ignoreDups = true;
    };

    shellAliases = {
      ls = "exa -l";
      la = "exa -la";
      lt = "exa -l --tree";

      cat = "bat";
    };
 
    sessionVariables = {
      LESSHISTFILE = "${config.xdg.dataHome}/less/history";

      AWS_SHARED_CREDENTIALS_FILE = "${config.xdg.configHome}/aws/credentials";
      AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";

      NVM_DIR="${config.xdg.dataHome}/nvm";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./.;
        file = "p10k.zsh";
      }
    ];    
  };
}
