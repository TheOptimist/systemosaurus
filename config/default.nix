# TODO: Use builtins to read all files in the directory.
# TODO: Create a darwin directory for specific home configuration?
{ pkgs, lib, ... }:

let
  inherit (lib) optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;
in  {

  imports = flatten [
    ./fonts.nix
    ./shell.nix
    ./vscode.nix
    ./home-manager.nix
    (optional isDarwin ./darwin)
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    exa
    tmux
    reattach-to-user-namespace

    lastpass-cli
    
  ];
}
