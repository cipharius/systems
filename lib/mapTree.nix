f: rootDir: let
  recurseDir = dir: let
    dirEntries = builtins.readDir dir;

    nameTypePairs = builtins.attrValues (
      builtins.mapAttrs (name: type: {
        name = name;
        type = type;
      })
      dirEntries
    );
    filteredNameTypePairs =
      builtins.filter (
        pair: let
          nameLen = builtins.stringLength pair.name;
          namePostfix = builtins.substring (nameLen - 4) 4 pair.name;
        in
          (pair.type == "directory")
          || ((pair.type == "regular" || pair.type == "symlink") && nameLen > 4 && namePostfix == ".nix")
      )
      nameTypePairs;

    modulesAttr =
      builtins.map
      (pair: {
        name =
          if pair.type == "directory"
          then pair.name
          else builtins.substring 0 ((builtins.stringLength pair.name) - 4) pair.name;

        value = let
          recursePath = "${dir}/${pair.name}";
        in
          if pair.type == "directory"
          then recurseDir recursePath
          else (f recursePath);
      })
      filteredNameTypePairs;
  in
    builtins.listToAttrs modulesAttr;
in
  recurseDir rootDir
