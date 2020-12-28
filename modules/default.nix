{ pkgs, lib, ... }:

let
  inherit (lib) optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;
in  {
  imports = flatten [
    (optional isDarwin ./darwin)
  ];
}
