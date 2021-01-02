{ config, pkgs, ... }:

let
  extensions = (with pkgs.vscode-extensions; [
    bbenoist.Nix
    pkief.material-icon-theme
  ]);
  customVSCode = pkgs.vscode-with-extensions.override {
    vscodeExtensions = extensions;
  };

in 
{
  environment.systemPackages = [ customVSCode ];
}
