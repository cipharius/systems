{inputs}: let
  l = inputs.self.lib // builtins;
in
  l.mapAttrs (
    host: hostCfg: let
      modulePaths =
        l.filter (value: l.isString value)
        (l.attrValues (
          l.mapTree (path: path) "${inputs.self}/hosts/${host}"
        ));

      hostSystem =
        if !(l.hasAttr "system" hostCfg)
        then l.abort "Host \"${host}\" is missing a required field \"system\""
        else if !(l.any (system: system == hostCfg.system) inputs.self.supportedSystems)
        then l.abort "Host's \"${host}\" system \"${hostCfg.system}\" is not listed in supportedSystems"
        else hostCfg.system;

      hostNixpkgs =
        if l.hasAttr "defaultNixpkgs" hostCfg
        then hostCfg.defaultNixpkgs
        else inputs.nixpkgs;

      hostPkgs = l.systemPkgs hostCfg.system hostNixpkgs;
      lib = hostPkgs.lib;
    in
      inputs.nixpkgs.lib.nixosSystem {
        system = hostSystem;

        specialArgs = {
          inherit inputs host hostCfg;
          presets = inputs.self.presets;
        };
        modules =
          modulePaths
          ++ [
            {
              networking.hostName = lib.mkDefault host;

              # Enable nix-command and flakes implicitely, since this repository is designed for flakes only configuration
              nix.settings.experimental-features = lib.mkDefault ["nix-command" "flakes"];

              nix.registry.nixpkgs.flake = hostNixpkgs;

              nixpkgs.pkgs = hostPkgs;
              nix.nixPath = [
                "nixpkgs=${hostNixpkgs}"
              ];

              environment.etc.nixos.source = inputs.self;

              system.stateVersion =
                if !(l.hasAttr "stateVersion" hostCfg)
                then l.abort "Host \"${host}\" is missing a required field \"stateVersion\""
                else hostCfg.stateVersion;
            }
          ];
      }
  )
