{inputs}: let
  l = inputs.self.lib // builtins;
  supportedSystems = inputs.self.supportedSystems;
in
  pkgsFlake: formatterName:
    l.forEach supportedSystems (
      system: (l.getAttr formatterName (l.systemPkgs system pkgsFlake))
    )
