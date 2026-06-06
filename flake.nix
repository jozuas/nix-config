{
  description = "Juozas's nix-darwin + NixOS + home-manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      nix-darwin,
      home-manager,
      nix-homebrew,
      nixos-hardware,
      ...
    }:
    let
      inherit (nixpkgs.lib)
        filterAttrs
        mapAttrs
        genAttrs
        unique
        mapAttrsToList
        ;

      mkUnstable =
        system:
        import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };

      # Expose the unstable channel as `pkgs.unstable.*`
      unstableOverlay = system: _final: _prev: {
        unstable = mkUnstable system;
      };

      mkSpecialArgs =
        {
          machine,
          isDarwin,
          ...
        }:
        let
          username = "juozas";
          homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
        in
        {
          inherit
            machine
            nixos-hardware
            isDarwin
            username
            homeDirectory
            ;
        };

      nixpkgsModule = system: {
        nixpkgs.overlays = [ (unstableOverlay system) ];
        nixpkgs.config.allowUnfree = true;
      };

      homeManagerModule =
        args:
        let
          specialArgs = mkSpecialArgs args;
        in
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.${specialArgs.username} = import ./home-manager/home.nix;
        };

      # Build a single host (NixOS or nix-darwin) from a `hosts` entry.
      mkHost =
        machine:
        { system, isDarwin }:
        let
          args = { inherit machine system isDarwin; };
          builder = if isDarwin then nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
          mainModule = if isDarwin then ./nix-darwin/darwin-configuration.nix else ./nixos/configuration.nix;
          hmModule =
            if isDarwin then
              home-manager.darwinModules.home-manager
            else
              home-manager.nixosModules.home-manager;
          darwinModules =
            if isDarwin then
              [
                nix-homebrew.darwinModules.nix-homebrew
                (
                  { username, ... }:
                  {
                    nix-homebrew = {
                      enable = true;
                      user = username;
                      autoMigrate = true;
                      # Also install Homebrew under the Intel prefix
                      # (/usr/local) via Rosetta 2, so x86-64 packages can be
                      # installed with `arch -x86_64 brew install <pkg>`.
                      enableRosetta = true;
                    };
                  }
                )
              ]
            else
              [ ];
        in
        builder {
          inherit system;
          specialArgs = mkSpecialArgs args;
          modules = [
            (nixpkgsModule system)
            mainModule
            hmModule
            (homeManagerModule args)
          ]
          ++ darwinModules;
        };

      # One line per machine. `isDarwin` selects the builder and module set.
      hosts = {
        mbp = {
          system = "aarch64-darwin";
          isDarwin = true;
        };
        t480s = {
          system = "x86_64-linux";
          isDarwin = false;
        };
      };

      configurations = mapAttrs mkHost hosts;

      # Every distinct system our hosts target.
      systems = unique (mapAttrsToList (_: host: host.system) hosts);
      forAllSystems = genAttrs systems;
    in
    {
      darwinConfigurations = filterAttrs (name: _: hosts.${name}.isDarwin) configurations;
      nixosConfigurations = filterAttrs (name: _: !hosts.${name}.isDarwin) configurations;

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);
    };
}
