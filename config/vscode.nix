{ config, pkgs, ... }:

let
  extensions = (with pkgs.vscode-extensions; [
    bbenoist.Nix
  ]);
  customVSCode = pkgs.vscode-with-extensions.override {
    vscodeExtensions = extensions;
  };

in 
{
  environment.systemPackages = [ customVSCode ];
}
