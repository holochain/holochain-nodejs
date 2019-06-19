{ pkgs, release }:
let
 name = "hcnjs-release-versions";

 script = pkgs.writeShellScriptBin name
 ''
 echo "bumping core version from ${release.version.previous} to ${release.version.current} in Cargo.toml"
 find . \
  -name "Cargo.toml" \
  -not -path "**/.git/**" \
  -not -path "**/.cargo/**" | xargs -I {} \
  sed -i 's/^\s*version\s*=\s*"${release.core.previous}"\s*$/version = "${release.core.current}"/g' {}
 find . \
  -name "Cargo.toml" \
  -not -path "**/.git/**" \
  -not -path "**/.cargo/**" | xargs -I {} \
  sed -i 's/\s*tag\s*=\s*"v${release.core.previous}"\s*/tag = "v${release.core.current}" /g' {}

 echo "bumping nodejs versions from ${release.version.previous} to ${release.version.current} in readmes"
 find . \
  -iname "readme.md" \
  -not -path "**/.git/**" \
  -not -path "**/.cargo/**" | xargs -I {} \
  sed -i 's/${release.version.previous}/${release.version.current}/g' {}

 echo "bumping nodejs version from ${release.version.previous} to ${release.version.current}"
 sed -i 's/^\s*version\s*=\s*"${release.version.previous}"\s*$/version = "${release.version.current}"/g' ./nodejs_conductor/native/Cargo.toml
 sed -i 's/"version": "${release.version.previous}"/"version": "${release.version.current}"/g' ./nodejs_conductor/package.json
 '';
in
{
 buildInputs = [ script ];
}
