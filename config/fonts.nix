{ pkgs, lib, ... }:

let
  inherit (lib) mkMerge mkIf optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

in
  mkMerge [
    {
      fonts.fonts = with pkgs; flatten [
        (nerdfonts.override {
          fonts = [
            "FiraCode"
            "Hack"
            "SourceCodePro"
          ];
        })

        alegreya-sans
        lato
        roboto
      ];
    }

    (mkIf isDarwin {
      fonts.enableFontDir = true;
    })
  ]
