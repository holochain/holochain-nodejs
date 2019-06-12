{ pkgs }:
{
  buildInputs = [
   (pkgs.callPackage ./nix/install.nix { })
   (pkgs.callPackage ./nix/test.nix { })
  ];
}
