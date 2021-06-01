{
  sources ? import ./nix/sources.nix
  , pkgs ? import sources.nixpkgs { overlays = [ (import ./nix/cypress-overlay.nix) ]; }
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nodejs
    yarn
    cypress
  ];
  CYPRESS_INSTALL_BINARY=0;
  CYPRESS_RUN_BINARY="${pkgs.cypress}/bin/Cypress";
}
