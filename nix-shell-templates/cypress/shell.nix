{
  sources ? import ./nix/sources.nix
  , pkgs ? import sources.nixpkgs {}
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nodejs
    cypress
  ];
  CYPRESS_INSTALL_BINARY=0;
  CYPRESS_RUN_BINARY="${pkgs.cypress}/bin/Cypress";
}
