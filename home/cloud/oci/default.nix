{ pkgs, config, ... }:

let
  ociConfigPath = "${config.xdg.configHome}/oci";
  ociConfigFile = "${ociConfigPath}/config";
  functions = builtins.readFile ./functions.sh;
  localFunctions = builtins.readFile ./functions.local.sh;

in {
  
  programs.zsh = {
    sessionVariables = {
      OCI_TENANT="$( cat ${ociConfigFile} | grep tenancy | cut -d'=' -f2 )";
    };

    shellAliases = {
      oci = "oci --config-file ${ociConfigFile}";
      swap-bastion = "() { if [[ -z \"\${1+x}\" ]]; then return 1; fi; swap_ssh_host bastion \$(get_public_ip \$1 bastion); kterm bastion router dc01 dc02 proxy; }";      
    };

    initExtra = ''
      ${functions}
      ${localFunctions}
      mkdir -p ${ociConfigPath}
    '';
  };
}