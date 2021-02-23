{ pkgs, config, ... }:

let
  ociConfigPath     = "${config.xdg.configHome}/oci";
  oci = pkgs.writeShellScriptBin "oci" ''
    docker run --rm -it -v ${ociConfigPath}:/root/.oci jpoon/oci-cli $@
  '';

  #functions = builtins.readFile ./functions.sh;

in {
  home.packages = [ oci ];

  programs.zsh = {
    sessionVariables = {
      OCI_TENANT="$( cat ${ociConfigPath}/config | grep tenancy | cut -d'=' -f2 )";
    };

    initExtra = ''
      mkdir -p ${ociConfigPath}
    '';
  };
}