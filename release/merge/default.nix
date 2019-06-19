{ pkgs, github, release }:
let

  name = "hcnjs-release-merge";

  script = pkgs.writeShellScriptBin name
  ''
  echo
  echo 'ensure github PR'
  if [ "$(git rev-parse --abbrev-ref HEAD)" == "${release.branch}" ]
   then
    git add . && git commit -am 'Release ${release.version.current}';
    git push;
    git pull ${github.upstream} master;
    git push ${github.upstream} master;
   else
    echo "current branch is not ${release.branch}!";
    exit 1;
  fi
  '';
in
{
 buildInputs = [ script ];
}
