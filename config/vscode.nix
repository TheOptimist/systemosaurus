{ config, pkgs, ... }:

# TODO: Save settings file here, create in store, and link to correct location
let
  extensions = (with pkgs.vscode-extensions; [
    bbenoist.Nix
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name      = "Material-theme";
      publisher = "zhuangtongfa";
      version   = "3.9.12";
      sha256    = "017h9hxplf2rhmlhn3vag0wypcx6gxi7p9fgllj5jzwrl2wsjl0g";
    }
    {
      name      = "vscode-icons";
      publisher = "vscode-icons-team";
      version   = "11.1.0";
      sha256    = "1xrz9f0nckx29wxpmlj1dqqiaal3002xwgzz5p9iss119sxgpwrx";
    }
    {
      name      = "one-dark-dark-plus";
      publisher = "brandonjmatthews";
      version   = "0.1.1";
      sha256    = "1k3y57lc7b5a2hzxj0arqhnzghd19rdpjhp5gdydjz3hap329zzz";
    }
    {
      name      = "rust";
      publisher = "rust-lang";
      version   = "0.7.8";
      sha256    = "039ns854v1k4jb9xqknrjkj8lf62nfcpfn0716ancmjc4f0xlzb3";
    }
    {
      name      = "terraform";
      publisher = "HashiCorp";
      version   = "2.7.0";
      sha256    = "0lpsng7rd88ppjybmypzw42czr6swwin5cyl78v36z3wjwqx26xp";
    }
    {
      name      = "gitlens";
      publisher = "eamodio";
      version   = "11.3.0";
      sha256    = "0py8c5h3pp99r0q9x2dgh1ryp05dbndyc5ipp999z3x1xvwnfrlv";
    }
    {
      name      = "githistory";
      publisher = "donjayamanne";
      version   = "0.6.14";
      sha256    = "11x116hzqnhgbryp2kqpki1z5mlnwxb0ly9r1513m5vgbisrsn0i";
    }
    {
      name      = "footsteps";
      publisher = "Wattenberger";
      version   = "0.1.0";
      sha256    = "1cvx9yr7n49wbkyvd63bd7j731ab1j2ka0y66nzp5bw8a6cilmjb";
    }
    {
      name      = "vscode-power-mode";
      publisher = "hoovercj";
      version   = "2.2.0";
      sha256    = "0v1vqkcsnwwbb7xbpq7dqwg1qww5vqq7rc38qfk3p6b4xhaf8scm";
    }
    {
      name      = "cform";
      publisher = "aws-scripting-guy";
      version   = "0.0.24";
      sha256    = "sha256-X3Om8uB94Va/uABnZhzm2ATbqj3wzqt/s2Z844lZcmU=";
    }
    {
      name      = "vscode-cfn-lint";
      publisher = "kddejong";
      version   = "0.20.0";
      sha256    = "sha256-XLKBONSAyFZndnPsZsvIXRhaORlE8U8WylGzaqQ6XFY=";
    }
    {
      name      = "vscode-yaml";
      publisher = "redhat";
      version   = "0.21.1";
      sha256    = "sha256-G47z2lUb2CYUc7g5v/NwjbZdK6XlERjPwXHRF4EmDN4=";
    }
  ]);
  customVSCode = pkgs.vscode-with-extensions.override {
    vscodeExtensions = extensions;
  };

in {
  environment.systemPackages = [ customVSCode ];
}
