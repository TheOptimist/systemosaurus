{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env = { "TERM" = "alacritty"; };

      font = {
        size = 14.0;
        use_thin_strokes = true;

        normal.family = "Hack Nerd Font";
      };

      #shell = "${pkgs.tmux}/bin/tmux";
    };
  };
}