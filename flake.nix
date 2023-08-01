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
        system = "x86_64-linux";
        defaultNixpkgs = nixpkgs;
        stateVersion = "23.05";
      };
    };

    formatter = self.lib.generateFormatter nixpkgs "alejandra";

    # TODO define devShells.<system>.default with tools such as agenix
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
