{ pkgs }:
{
  buildInputs = []
  ++ (pkgs.callPackage ./install { }).buildInputs
  ++ (pkgs.callPackage ./test { }).buildInputs
  ;
}
