{
  imports = [
    ./aws.nix
    ./oci
  ];

  programs.zsh = {
    shellAliases = {
      # Terraform in docker
      terraform = "docker run --rm -it -v \$(pwd):/workspace -w /workspace hashicorp/terraform:0.14.4";
    };
  };
}