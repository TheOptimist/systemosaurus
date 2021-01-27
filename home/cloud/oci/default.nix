{ config, ... }:

let
  ociConfigPath = "${config.xdg.configHome}/oci";
  ociConfigFile = "${ociConfigPath}/config";
  #functions = builtins.readFile ./functions.sh;

in {
  programs.zsh = {

    shellAliases = {
      oci = "docker run --rm -it -v ${ociConfigPath}:/root/.oci jpoon/oci-cli";
    };

    sessionVariables = {
      OCI_TENANT="$( cat ${ociConfigFile} | grep tenancy | cut -d'=' -f2 )";
    };

    initExtra = ''
      mkdir -p ${ociConfigPath}
    '';
  };
}