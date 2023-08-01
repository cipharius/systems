list: f: let
  fAttr = name: {
    name = name;
    value = f name;
  };
in
  builtins.listToAttrs (builtins.map fAttr list)
