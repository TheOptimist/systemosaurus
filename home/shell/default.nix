{ pkgs, lib, config, ... }:

let
  functions = builtins.readFile ./functions.sh;

in rec {
  programs.zsh = {
    enable = true;
    # TODO: These aren't recognised ??
#    enableAutoSuggestions = true;
#    enableCompletion = true;

    # Frustratingly this has to be relative to $HOME (so far)
    # Using xdg.configHome ends up with a /Users/george/Users/george (at least in Darwin)
    # Be nicer if I didn't have to hardcode the XDG config directory
    dotDir = ".config/zsh";

    history = {
      path = "${programs.zsh.dotDir}/.zsh_history";
      size = 5000;
      save = 50000;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };

    shellAliases = {
      reshell = "source ${config.xdg.configHome}/zsh/.zshrc";

      ls  = "exa -l";
      la  = "exa -la";
      lt  = "exa -l --tree --level 2";
      lta = "exa -l --tree";

      cat    = "bat";
      catp   = "cat -pp";

      nixd   = "darwin-rebuild";
      nixgc  = "nix-collect-garbage";
      
      please = "sudo";
    };
 
    sessionVariables = {
      LESSHISTFILE = "${config.xdg.dataHome}/less/history";
      CARGO_HOME = "${config.xdg.configHome}/cargo";
      NVM_DIR="${config.xdg.dataHome}/nvm";
    };

    initExtra = ''
      ${functions}

      # Fix homebrew directories that are group readable
      if [ ! compaudit ]; then compaudit | xargs chmod g-w; fi

      eval "$(direnv hook zsh)"
    '';

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
