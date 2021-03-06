{ pkgs, config, ... }:

let
  ociConfigPath = "${config.xdg.configHome}/oci";
  ociConfigFile = "${ociConfigPath}/config";
  functions = builtins.readFile ./functions.sh;

in {
  
  programs.zsh = {
    sessionVariables = {
      OCI_TENANT="$( cat ${ociConfigFile} | grep tenancy | cut -d'=' -f2 )";
    };

    shellAliases = {
      oci = "oci --config-file ${ociConfigFile}";
    };

    initExtra = ''
      ${functions}
      mkdir -p ${ociConfigPath}
    '';
  };
}