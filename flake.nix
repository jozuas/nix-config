{
  description = "Juozas's nix-darwin + NixOS + home-manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      nix-darwin,
      home-manager,
      nixos-hardware,
      ...
    }:
    let
      mkUnstable =
        system:
        import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };

      mkSpecialArgs =
        { machine, system, isDarwin }:
        {
          inherit machine nixos-hardware isDarwin;
          pkgs-unstable = mkUnstable system;
        };

      homeManagerModule =
        args:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = mkSpecialArgs args;
          home-manager.users.juozas = import ./home-manager/home.nix;
        };

      mkDarwin =
        { machine, system }:
        let args = { inherit machine system; isDarwin = true; }; in
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = mkSpecialArgs args;
          modules = [
            ./nix-darwin/darwin-configuration.nix
            home-manager.darwinModules.home-manager
            (homeManagerModule args)
          ];
        };

      mkNixos =
        { machine, system }:
        let args = { inherit machine system; isDarwin = false; }; in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = mkSpecialArgs args;
          modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            (homeManagerModule args)
          ];
        };
    in
    {
      darwinConfigurations = {
        mbp = mkDarwin {
          machine = "mbp";
          system = "aarch64-darwin";
        };
      };

      nixosConfigurations = {
        t480s = mkNixos {
          machine = "t480s";
          system = "x86_64-linux";
        };
      };
    };
}
