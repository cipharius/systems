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

  nix = {
    settings = {
      sandbox = true;
      trusted-users = ["root" "@wheel"];
      auto-optimise-store = true;
      allowed-users = ["@wheel"];

      # Enable nix-command and flakes implicitely, since this repository is designed for flakes only configuration
      experimental-features = lib.mkDefault ["nix-command" "flakes"];
    };

    gc.automatic = true;
    optimise.automatic = true;

    extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';

    registry.nixpkgs.flake = hostNixpkgs;
    registry.haumea.flake = inputs.haumea;

    nixPath = ["nixpkgs=${hostNixpkgs}"];
  };

  environment.etc.nixos.source = inputs.self;

  system.stateVersion =
    if !(l.hasAttr "stateVersion" hostCfg)
    then l.abort "Host \"${host}\" is missing a required field \"stateVersion\""
    else hostCfg.stateVersion;

  users.mutableUsers = lib.mkDefault false;

  services.earlyoom.enable = true;

  boot.tmp.useTmpfs = true;
}
