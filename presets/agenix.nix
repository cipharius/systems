{
  inputs,
  lib,
  config,
  ...
}: let
  system = config.nixpkgs.hostPlatform.system;
in {
  imports = [
    inputs.agenix.nixosModules.default
  ];
  nix.registry.agenix.flake = inputs.agenix;

  environment.systemPackages = [
    inputs.agenix.packages.${system}.default
  ];

  # Agenix requires all hosts to have a key pair
  services.openssh.enable = true;
  services.openssh.openFirewall = lib.mkDefault false;
}
