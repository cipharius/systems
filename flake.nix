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
  };
}
