{ pkgs }:
{
  buildInputs = [
   (pkgs.callPackage ./nix/install.nix { })
  ];
}
