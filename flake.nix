# Repository's entry point
# Keep this file as clear as possible, let it serve as repository's index
{
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    supportedSystems = [
      "x86_64-linux"
    ];

    lib = import ./lib/default.nix {inherit inputs;};

    presets = self.lib.generatePresets;

    nixosConfigurations = self.lib.generateNixosConfigurations {
      test = {
        defaultNixpkgs = nixpkgs;
        stateVersion = "23.05";
      };

      caminus = {
        defaultNixpkgs = nixpkgs;
        stateVersion = "23.05";
        modules = [
          inputs.home-manager.nixosModules.default
          inputs.agenix.nixosModules.default
        ];
      };
    };

    formatter = self.lib.generateFormatter nixpkgs "alejandra";

    # TODO define devShells.<system>.default with tools such as agenix
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Core dependencies
    # Must be manually updated to prevent breakage
    nixpkgs-core.url = "github:nixos/nixpkgs/66aedfd010204949cb225cf749be08cb13ce1813";

    haumea.url = "github:nix-community/haumea/d6a9593ff2160ce29bf6d905e9ccbcecd66baeef";
    haumea.inputs.nixpkgs.follows = "nixpkgs-core";

    home-manager.url = "github:nix-community/home-manager/86dd48d70a2e2c17e84e747ba4faa92453e68d4a";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-core";

    agenix.url = "github:ryantm/agenix/d8c973fd228949736dedf61b7f8cc1ece3236792";
    agenix.inputs.home-manager.follows = "home-manager";
    agenix.inputs.nixpkgs.follows = "nixpkgs-core";
  };
}
