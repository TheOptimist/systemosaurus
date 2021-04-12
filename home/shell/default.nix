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
      
      isvg = "rsvg-convert | icat";
      icat = "kitty icat --align=left";

      please = "sudo";
      ktty = "echo \"/nix/store/$(ls /nix/store | grep '^d.*kitty-terminfo' | awk '{print $7}')/kitty.terminfo\"";
    };
 
    sessionVariables = {
      GITHUB_EMAIL = "5285122+TheOptimist@users.noreply.github.com";
      GITHUB_API_TOKEN = "$(lp show --password api_tokens/github_tehama)";
      GPG_TTY = "$(tty)";
      LESSHISTFILE = "${config.xdg.dataHome}/less/history";
      CARGO_HOME = "${config.xdg.configHome}/cargo";
      NVM_DIR="${config.xdg.dataHome}/nvm";
    };

    initExtra = ''
      ${functions}

      # kitty
      bindkey "\e[1;3D" backward-word # ⌥←
      bindkey "\e[1;3C" forward-word  # ⌥→
      
      # Fix homebrew directories that are group readable
      if [ ! compaudit ]; then compaudit | xargs chmod g-w; fi

      eval "$(direnv hook zsh)"

      unsetopt share_history
      setopt no_share_history

      ln -s -f ~/.config/nixpkgs/home/shell/tmux.conf ~/.tmux.conf
      ln -s -f ~/.config/nixpkgs/home/shell/tmux.conf.local ~/.tmux.conf.local

      export PATH="/usr/local/sbin:$PATH";
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
