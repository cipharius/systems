{
  lib,
  presets,
  ...
}: {
  home-manager.useGlobalPkgs = lib.mkDefault true;
  home-manager.useUserPackages = lib.mkDefault true;
  home-manager.extraSpecialArgs = {inherit presets;};
}
