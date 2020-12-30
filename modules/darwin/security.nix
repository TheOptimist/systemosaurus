{ config, lib, pkgs, ... }:

# Lifted directly from https://github.com/malob/nixpkgs/blob/master/darwin/modules/security/pam.nix
# Pull request to nix-darwin https://github.com/LnL7/nix-darwin/pull/228
with lib;

let
  cfg = config.security.pam;

  # Implementation Notes
  #
  # We don't use `environment.etc` because this would require that the user manually delete
  # `/etc/pam.d/sudo` which seems unwise given that applying the nix-darwin configuration requires
  # sudo. We also can't use `system.patchs` since it only runs once, and so won't patch in the
  # changes again after OS updates (which remove modifications to this file).
  #
  # As such, we resort to line addition/deletion in place using `sed`. We add a comment to the
  # added line that includes the name of the option, to make it easier to identify the line that
  # should be deleted when the option is disabled.
  mkUpdatePamSudoFile = isEnabled: authLevel: authModule: option:
  let
    file = "/etc/pam.d/sudo";
  in ''
    ${if isEnabled then ''
      # Enable ${authModule} if not already enabled

      if ! grep '${authModule}' ${file} > /dev/null; then
        auth_entry=$(printf "%-10s %-14s %-24s %s" "auth" "${authLevel}" "${authModule}" "# nix-darwin: ${option}")
        sed -i "" "2i\\
      $auth_entry
        " ${file}
      fi
    '' else ''
      # Disable ${authModule} if added by nix-darwin
      if grep '${option}' ${file} > /dev/null; then
        sed -i "" '/${option}/d' ${file}
      fi
    ''}
  '';

  mkTouchIDForSudoScript = isEnabled:
  let
    authLevel = "sufficient";
    authModule = "pam_tid.so";
    option = "security.pam.enableSudoTouchIdAuth";
  in
    mkUpdatePamSudoFile isEnabled authLevel authModule option;
  
  mkReattachToSessionNamepsaceScript = isEnabled:
  let
    authLevel = "optional";
    authModule = "pam_reattach.so";
    option = "security.pam.enableReattachToSessionNamepsace";
  in
    mkUpdatePamSudoFile isEnabled authLevel authModule option;

in

{
  options.security.pam = {
    useTouchIdForSudo.enable = mkEnableOption ''
      Enable sudo authentication with Touch ID

      When enabled, this option adds the following line to /etc/pam.d/sudo:

          auth       sufficient     pam_tid.so

      (Note that macOS resets this file when doing a system update. As such, sudo
      authentication with Touch ID won't work after a system update until the nix-darwin
      configuration is reapplied.)
    '';

    reattachToSessionNamespace.enable = mkEnableOption ''
      Enable reattaching to the users per-session bootstrap namespace on MacOS.

      When enabled, this option adds the following line to /etc/pam.d/sudo:

          auth       optional       pam_reattach.so
      
      This option requires the prior installation of `pam_reattach` likely through
      Homebrew.
    '';
  };

  config = {
    system.activationScripts.pam.text = ''
      # PAM settings
      echo >&2 "setting up pam..."
      ${mkTouchIDForSudoScript cfg.useTouchIdForSudo.enable}
      ${mkReattachToSessionNamepsaceScript cfg.reattachToSessionNamespace.enable}
    '';
  };
}