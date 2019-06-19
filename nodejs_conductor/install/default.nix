{ pkgs }:
let
  name = "hcnjs-conductor-install";

  script = pkgs.writeShellScriptBin name
  ''
  echo "installing node conductor"
  hc-node-flush
  ( \
   cd nodejs_conductor \
   && yarn install --ignore-scripts \
   && RUST_SODIUM_DISABLE_PIE=1 node ./publish.js \
  )
  '';
in
{
 buildInputs = [ script ];
}
