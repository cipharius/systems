{
  inputs,
  hostCfg,
  lib,
  ...
}: {
  home-manager.users.root.home.stateVersion = hostCfg.stateVersion;

  age.secrets.root.file = "${inputs.self}/secrets/root.age";
  users.users.root.hashedPasswordFile = "/run/agenix/root";
}
