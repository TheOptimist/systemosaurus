{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env = { "TERM" = "xterm-256color"; };

      font = {
        size = 12.0;
        use_thin_strokes = true;

        normal.family = "SauceCodePro Nerd Font";
      };

      shell = "${pkgs.tmux}/bin/tmux";
    };
  };
}