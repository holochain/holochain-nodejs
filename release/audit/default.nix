{ pkgs, release }:
let
 name = "hcnjs-release-audit";

 script = pkgs.writeShellScriptBin name
 ''
 echo
 echo "Current git:"
 echo
 git show --pretty=oneline
 echo
 echo "All the important release vars:"
 echo
 echo "Target commit: ${release.commit}"
 echo
 echo "New nodejs conductor version: ${release.version.current}"
 echo "Previous nodejs conductor version: ${release.version.previous}"
 echo
 echo "Release process url: ${release.process-url}"
 '';
in
{
 buildInputs = [ script ];
}
