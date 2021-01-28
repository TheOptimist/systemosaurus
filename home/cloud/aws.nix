{ config, ... }:

let
  awsConfigHome = "${config.xdg.configHome}/aws";
  
in {

  programs.zsh = {

    shellAliases = {
      # AWS in docker
      aws = "docker run --rm -it -v ${awsConfigHome}:/root/.aws amazon/aws-cli:2.1.18";
    };

    initExtra = ''
      mkdir -p ${awsConfigHome}
    '';
  };
}