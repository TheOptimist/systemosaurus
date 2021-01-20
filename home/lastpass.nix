{ config, ... }:

let
  persLastPassConfig = "${config.xdg.configHome}/lpass/p";
  workLastPassConfig = "${config.xdg.configHome}/lpass/w";

in {

  programs.zsh = {

    shellAliases = {
      lp = "export LPASS_HOME=${persLastPassConfig} && lpass";
      tp = "export LPASS_HOME=${workLastPassConfig} && lpass";
    };

    initExtra = ''
      mkdir -p ${persLastPassConfig}
      mkdir -p ${workLastPassConfig}
    '';
  };
}