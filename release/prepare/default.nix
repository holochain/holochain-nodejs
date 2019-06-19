{ pkgs }:
let
  name = "hcnjs-release-prepare";

  script = pkgs.writeShellScriptBin name
  ''
  echo
  hcnjs-release-audit
  echo
  read -r -p "Are you sure you want to cut a new release based on the current config in shell.nix? [y/N] " response
  case "$response" in
   [yY][eE][sS]|[yY])
    hcnjs-release-branch \
    && hcnjs-release-versions \
    && hcnjs-release-merge \
    ;;
   *)
    exit 1
    ;;
  esac
  '';
in
{
 buildInputs = [ script ];
}
