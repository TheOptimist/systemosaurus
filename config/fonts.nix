{ pkgs, lib, ... }:

let
  inherit (lib) mkMerge mkIf optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

in

  mkMerge [
    {
      fonts.fonts = with pkgs; flatten [
        (nerdfonts.override {
          fonts = [ "FiraCode" "SourceCodePro" ];
        })
      ];
    }

    (mkIf isDarwin {
      fonts.enableFontDir = true;
    })
  ]
