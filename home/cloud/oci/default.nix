{ config, ... }:

let
  ociConfigHome = "${config.xdg.configHome}/oci";

in {

  programs.zsh = {

    shellAliases = {
      # OCI in docker
      oci = "docker run --rm -it -v ${ociConfigHome}:/root/.oci jpoon/oci-cli";
    };

    sessionVariables = {
      OCI_TENANT="$( cat ${ociConfigHome}/config | grep tenancy | cut -d'=' -f2 )";
    };

    initExtra = ''
      ${functions}
      mkdir -p ${ociConfigHome}
    '';
  };
}