{inputs}: let
  l = inputs.self.lib // builtins;
in
  l.mapAttrs (
    host: hostCfg: let
      modulePaths = l.attrValues (inputs.haumea.lib.load {
        src = "${inputs.self}/hosts/${host}";
        loader = inputs.haumea.lib.loaders.path;
      });

      customModulePaths = l.attrValues (inputs.haumea.lib.load {
        src = "${inputs.self}/custom/modules";
        loader = inputs.haumea.lib.loaders.path;
      });

      extraModules =
        if l.hasAttr "modules" hostCfg
        then hostCfg.modules
        else [];

      # hostSystem =
      #   if !(l.hasAttr "system" hostCfg)
      #   then l.abort "Host \"${host}\" is missing a required field \"system\""
      #   else if !(l.any (system: system == hostCfg.system) inputs.self.supportedSystems)
      #   then l.abort "Host's \"${host}\" system \"${hostCfg.system}\" is not listed in supportedSystems"
      #   else hostCfg.system;

      hostNixpkgs =
        if l.hasAttr "defaultNixpkgs" hostCfg
        then hostCfg.defaultNixpkgs
        else inputs.nixpkgs;
      # hostPkgs = l.systemPkgs hostCfg.system hostNixpkgs;
      # lib = hostPkgs.lib;
    in
      hostNixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs host hostCfg;
          presets = inputs.self.presets;
        };
        modules = customModulePaths ++ extraModules ++ modulePaths;
      }
  )
