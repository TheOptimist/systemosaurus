{ pkgs, config, ... }:

let
  # Yeah, this should probably be OCI specific really...
  terraform = pkgs.writeShellScriptBin "terraform" ''
    docker run --rm -it -v ${config.xdg.configHome}/oci:/keys:ro -v $(pwd):/workspace -w /workspace hashicorp/terraform:0.14.4 $@
  '';

in {
  imports = [
    ./aws.nix
    ./oci
  ];

  home.packages = [
    terraform
    pkgs.tflint
  ];
}