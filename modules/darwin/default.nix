# TODO: Use builtins to read all files in the directory.
{ pkgs, options, ... }:

{
  imports = [
    <darwin/modules/homebrew.nix>
    ./security.nix
  ];
}
