{ pkgs, config, ... }:

let
  
in {

  imports = [ 
    #"./wrapper.nix"
  ];
  
  programs.tmux = {
    enable = true;
    # TODO: Plugins here have to be added manually to the [custom configuration](./tmux.conf)
    plugins = (with pkgs.tmuxPlugins; [
      resurrect
    ]);
  };

  xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;

  programs.zsh.shellAliases = {
    tmux = "tmux -f ${config.xdg.configHome}/tmux/tmux.conf";
    ta   = "tmux attach -t";
    ts   = "tmux new-session -s";
    tl   = "tmux list-sessions";
  };
}
