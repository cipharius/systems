{inputs, lib, ...}: {
  imports = [
    inputs.agenix.nixosModules.default
  ];
  nix.registry.agenix.flake = inputs.agenix;

  # Agenix requires all hosts to have a key pair
  services.openssh.enable = true;
  services.openssh.openFirewall = lib.mkDefault false;
}
