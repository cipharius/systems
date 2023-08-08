{inputs}: {
  # Flake output generators
  generateFormatter = import ./generateFormatter.nix {inherit inputs;};
  generateNixosConfigurations = import ./generateNixosConfigurations.nix {inherit inputs;};
  generatePresets = import ./generatePresets.nix {inherit inputs;};

  # Pure functions
  forEach = import ./forEach.nix;
  systemPkgs = import ./systemPkgs.nix;
}
