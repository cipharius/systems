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
      # test = {
      #   defaultNixpkgs = nixpkgs;
      #   stateVersion = "23.05";
      # };

      caminus = {
        defaultNixpkgs = nixpkgs;
        stateVersion = "23.05";
      };

      mcg-valts = {
        defaultNixpkgs = nixpkgs;
        stateVersion = "23.05";
      };

      ciphus = {
        defaultNixpkgs = nixpkgs;
        stateVersion = "23.11";
      };
    };

    formatter = self.lib.generateFormatter nixpkgs "alejandra";

    # TODO define devShells.<system>.default with tools such as agenix
  };

  # Remember to add flake inputs to nix.registry to ensure offline rebuilds
  # TODO Maybe possible to write nix check that detects unpinned input which would prevent offline rebuild?
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";

    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";

    # Core dependencies
    # Must be manually updated to prevent breakage
    nixpkgs-core.url = "github:nixos/nixpkgs/f81bb6b77e190eb6f93053fb3e917501dbaf6291";

    haumea.url = "github:nix-community/haumea/ec6350fd9353e7f27ce0e85d31f82e3ed73e4d70";
    haumea.inputs.nixpkgs.follows = "nixpkgs-core";

    home-manager.url = "github:nix-community/home-manager/501cfec8277f931a9c9af9f23d3105c537faeafe";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-core";

    agenix.url = "github:ryantm/agenix/531beac616433bac6f9e2a19feb8e99a22a66baf";
    agenix.inputs.home-manager.follows = "home-manager";
    agenix.inputs.nixpkgs.follows = "nixpkgs-core";
  };
}
