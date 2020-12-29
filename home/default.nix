# TODO: Use builtins to read all files in the directory.
# TODO: Create a darwin directory for specific home configuration?
{
  imports = [
    ./git.nix
    ./zsh.nix
    ./tmux
    ./alacritty.nix
  ];
}
