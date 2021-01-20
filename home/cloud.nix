{ config, ... }:

let
  awsConfigHome = "${config.xdg.configHome}/aws";
  ociConfigHome = "${config.xdg.configHome}/oci";

in {

  programs.zsh = {

    shellAliases = {
      # AWS in docker
      aws = "docker run --rm -it -v ${awsConfigHome}:/root/.aws amazon/aws-cli:2.1.18";
      # OCI in docker
      oci = "docker run --rm -it -v ${ociConfigHome}:/root/.oci jpoon/oci-cli";
      # Terraform in docker
      terraform = "docker run --rm -it -v \${pwd}:/workspace -w /workspace hashicorp/terraform:0.14.4";
    };

    initExtra = ''
      mkdir -p ${awsConfigHome}
      mkdir -p ${ociConfigHome}
    '';
  };
}