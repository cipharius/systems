{
  config,
  lib,
  ...
}: {
  options = {
    nixpkgs.allowUnfreeWhitelist = lib.mkOption {
      default = [];
      description = "A whitelist of allowed unfree packages";
      type = with lib.types; listOf str;
    };
  };

  config = {
    nixpkgs.config.allowUnfreePredicate = (
      pkg:
        builtins.elem (lib.getName pkg) config.nixpkgs.allowUnfreeWhitelist
    );
  };
}
