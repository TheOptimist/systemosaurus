# TODO: Use builtins to read all files in the directory.
# TODO: Create a darwin directory for specific home configuration?
{ pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./shell.nix
    ./vscode.nix
  ];

  environment.systemPackages = with pkgs; [
    exa
    httpie
    alacritty
    tmux
  ];
}
