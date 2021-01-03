{ pkgs, config, symlinkJoin, makeWraper, ... }:

let
  customTmux = pkgs.symlinkJoin {
    name = "tmux";
    paths = [ pkgs.tmux ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/tmux" --add-flags "-f ${./tmux.conf}"
    '';
  };

in {

  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    package = customTmux;

    # TODO: Plugins here have to be added manually to the [custom configuration](./tmux.conf)
    plugins = (with pkgs.tmuxPlugins; [
      resurrect
    ]);
  };

  #xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;

  programs.zsh.shellAliases = {
    #tmux = "tmux -f ${config.xdg.configHome}/tmux/tmux.conf";
    ta   = "tmux attach -t";
    ts   = "tmux new-session -s";
    tl   = "tmux list-sessions";
  };
}
