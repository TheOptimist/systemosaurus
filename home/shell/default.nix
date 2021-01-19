{ pkgs, lib, config, ... }:

rec {
  programs.zsh = {
    enable = true;
    # TODO: These aren't recognised ??
#    enableAutoSuggestions = true;
#    enableCompletion = true;

    # Frustratingly this has to be relative to $HOME (so far)
    # Using xdg.configHome ends up with a /Users/george/Users/george (at least in Darwin)
    # Be nicer if I didn't have to hardcode the XDG config directory
    dotDir = ".config/zsh";

    history = {
      path = "${programs.zsh.dotDir}/.zsh_history";
      size = 5000;
      save = 50000;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };

    shellAliases = {
      reshell = "source ${config.xdg.configHome}/zsh/.zshrc";

      ls = "exa -l";
      la = "exa -la";
      lt = "exa -l --tree";

      cat = "bat";

      # AWS in docker
      aws = "docker --run -it -v ${config.xdg.configHome}/aws:/root/.aws amazon/aws-cli:2.1.18";
      # OCI in docker
      oci = "docker --run -it -v ${config.xdg.configHome}/oci:/root/.oci jpoon/oci-cli";
      # Terraform in docker
      terraform = "docker run --rm -it -v \${pwd}:/workspace -w workspace hashicorp/terraform:0.14.4";
    };
 
    sessionVariables = {
      LESSHISTFILE = "${config.xdg.dataHome}/less/history";

      AWS_SHARED_CREDENTIALS_FILE = "${config.xdg.configHome}/aws/credentials";
      AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";

      NVM_DIR="${config.xdg.dataHome}/nvm";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./.;
        file = "p10k.zsh";
      }
    ];    
  };
}
