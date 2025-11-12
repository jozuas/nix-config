{ fetchFromGitHub, pkgs, ... }:

pkgs.buildNpmPackage rec {
  pname = "claude-code-acp";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "carlrannaberg";
    repo = "cc-acp";
    rev = "v${version}";
    sha256 = "sha256-WO3WUAMpLNbXUZA/8vcn05FhEIM9nCgWbeEhLFqvA/E=";
  };

  npmDepsHash = "sha256-AWpTIUeYQBi6KEF0yH2jrBSb7APd9Dh/NY6RMVStHGQ=";

  # The package.json specifies Node.js >= 18.0.0
  buildInputs = [ pkgs.nodejs ];

  # Build phase - runs npm run build which uses esbuild
  npmBuildScript = "build";

  # Install phase - the package.json defines a bin entry for cc-acp
  # buildNpmPackage will handle this automatically

  meta = with pkgs.lib; {
    description = "Claude Code agent for Zed Editor via Agent Client Protocol";
    homepage = "https://github.com/carlrannaberg/cc-acp";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = "cc-acp";
  };
}
