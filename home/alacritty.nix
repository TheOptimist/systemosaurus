{ pkgs, ... }:

{
  xdg.configFile = {
    "alacritty/alacritty.yml".text = ''
      shell:
        # Use nix installed tmux
        program: ${pkgs.tmux}/bin/tmux
    '';
  };
}