{
  lib,
  inputs,
  presets,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];
  nix.registry.home-manager.flake = inputs.home-manager;

  home-manager.useGlobalPkgs = lib.mkDefault true;
  home-manager.useUserPackages = lib.mkDefault true;
  home-manager.extraSpecialArgs = {inherit presets;};
}
