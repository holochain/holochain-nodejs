{ pkgs }:
let
  name = "hcnjs-conductor-test";

  script = pkgs.writeShellScriptBin name
  ''
  hcnjs-conductor-install \
  && ( cd nodejs_conductor && npm test );
  '';
in
{
 buildInputs = [ script ];
}
