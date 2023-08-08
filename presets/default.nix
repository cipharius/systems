{
  inputs,
  host,
  hostCfg,
  lib,
  ...
}: let
  l = inputs.self.lib // builtins;
  hostNixpkgs =
    if l.hasAttr "defaultNixpkgs" hostCfg
    then hostCfg.defaultNixpkgs
    else inputs.nixpkgs;
in {
  networking.hostName = lib.mkDefault host;

  # Enable nix-command and flakes implicitely, since this repository is designed for flakes only configuration
  nix.settings.experimental-features = lib.mkDefault ["nix-command" "flakes"];

  nix.registry.nixpkgs.flake = hostNixpkgs;

  nix.nixPath = [
    "nixpkgs=${hostNixpkgs}"
  ];

  environment.etc.nixos.source = inputs.self;

  system.stateVersion =
    if !(l.hasAttr "stateVersion" hostCfg)
    then l.abort "Host \"${host}\" is missing a required field \"stateVersion\""
    else hostCfg.stateVersion;
}
