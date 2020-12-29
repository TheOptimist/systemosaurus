{ pkgs, lib, ... }:

let
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux;

in {

  programs.tmux.enable = true;

  xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;

  programs.zsh.shellAliases = {
    tmux = "tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf";
    ta   = "tmux attach -t";
    ts   = "tmux new-session -s";
    tl   = "tmux list-sessions";
  };
}
