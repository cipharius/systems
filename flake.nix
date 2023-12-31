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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";

    # Core dependencies
    # Must be manually updated to prevent breakage
    nixpkgs-core.url = "github:nixos/nixpkgs/91050ea1e57e50388fa87a3302ba12d188ef723a";

    haumea.url = "github:nix-community/haumea/d6a9593ff2160ce29bf6d905e9ccbcecd66baeef";
    haumea.inputs.nixpkgs.follows = "nixpkgs-core";

    home-manager.url = "github:nix-community/home-manager/948703f3e71f1332a0cb535ebaf5cb14946e3724";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-core";

    agenix.url = "github:ryantm/agenix/d8c973fd228949736dedf61b7f8cc1ece3236792";
    agenix.inputs.home-manager.follows = "home-manager";
    agenix.inputs.nixpkgs.follows = "nixpkgs-core";
  };
}
