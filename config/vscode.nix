{ config, pkgs, ... }:

# TODO: Save settings file here, create in store, and link to correct location
let
  extensions = (with pkgs.vscode-extensions; [
    bbenoist.Nix
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "Material-theme";
      publisher = "zhuangtongfa";
      version = "3.9.12";
      sha256 = "017h9hxplf2rhmlhn3vag0wypcx6gxi7p9fgllj5jzwrl2wsjl0g";
    }
    {
      name = "vscode-icons";
      publisher = "vscode-icons-team";
      version = "11.1.0";
      sha256 = "1xrz9f0nckx29wxpmlj1dqqiaal3002xwgzz5p9iss119sxgpwrx";
    }
  ]);
  customVSCode = pkgs.vscode-with-extensions.override {
    vscodeExtensions = extensions;
  };

in 
{
  environment.systemPackages = [ customVSCode ];
}
