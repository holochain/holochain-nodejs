{ pkgs }:
let
 release = import ./config.nix;

 github = pkgs.callPackage ./github { };
in
{
 buildInputs = []

 ++ (pkgs.callPackage ./audit {
  release = release;
 }).buildInputs

 ++ (pkgs.callPackage ./branch {
  release = release;
  github = github;
 }).buildInputs

 ++ (pkgs.callPackage ./merge {
  release = release;
  github = github;
 }).buildInputs

 ++ (pkgs.callPackage ./prepare { }).buildInputs

 ++ (pkgs.callPackage ./versions {
  release = release;
 }).buildInputs

 ;
}
