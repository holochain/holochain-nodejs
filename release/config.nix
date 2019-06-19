rec {
 # the commit from `develop` branch that the release is targetting
 # the final release(s) will differ from this due to changelog updates etc.
 commit = "a81e7259e6e7d90fbfd7392236483782526f4b06";

 # current documentation for the release process
 process-url = "https://hackmd.io/LTG8XfU4Q_6VB98tXz8Gag";

 version = {
  previous = "0.4.18-alpha1";
  current = "0.4.19-alpha1";
 };

 core = {
  previous = "0.0.19-alpha1";
  current = "0.0.20-alpha3";
 };

 tag = "v${version.current}";
 branch = "release-${version.current}";
}
