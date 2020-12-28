{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./config
    ./modules
    ./profiles
  ];
}
