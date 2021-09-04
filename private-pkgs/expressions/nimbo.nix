# For my own testing for building Nimbo from master

{
  unstable-pkgs ? import <unstable> {}
}:

unstable-pkgs.callPackage
  (
    { lib
    , fetchFromGitHub
    , python3
    }:


    let
      py = python3.override {
        packageOverrides = self: super: {
          colorama = super.colorama.overridePythonAttrs (oldAttrs: rec {
            version = "0.4.3";
            src = oldAttrs.src.override {
              inherit version;
              sha256 = "189n8hpijy14jfan4ha9f5n06mnl33cxz7ay92wjqgkr639s0vg9";
            };
          });
        };
      };

    in
    with py.pkgs.pythonPackages; buildPythonApplication rec {
      pname = "nimbo";
      version = "0.2.11";

      src = fetchFromGitHub {
        owner = "nimbo-sh";
        repo = pname;
        rev = "902d7d71d06ed0cd635f3ed8763e206390e25135";
        sha256 = "1c255pwl9pw989d2i0qmn4h0k1zr33fvwfhk1vz04y923gixx38s";
      };

      propagatedBuildInputs = [
        unstable-pkgs.awscli

        setuptools
        boto3
        requests
        click
        pyyaml
        pydantic
        rich
      ];

      # nimbo tests require an AWS instance
      doCheck = false;
      pythonImportsCheck = [ "nimbo" ];
    }
  )
{ }
