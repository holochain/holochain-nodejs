{ pkgs }:
let
 github = import ./config.nix;
in
github // {
 buildInputs = [];
}
