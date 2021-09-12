{ lib
, fetchFromGitHub
, python3
, pkgs
}:

with pkgs.python3Packages; buildPythonApplication rec {
  pname = "S4";
  version = "0.4.4";

  src = fetchFromGitHub {
    owner = "MichaelAquilina";
    repo = pname;
    rev = version;
    sha256 = "06jmikljxqq5fvnqxxjfff1nhwyhca6w74g55hzs6qxsljsppz8g";
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
    setuptools
    clint
    filelock
    python_magic
    tabulate
    tqdm
    inotify-simple
    pathspec
    boto3
  ];
}
