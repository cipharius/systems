{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.fossil;
in {
  options = {
    services.fossil = {
      enable = lib.mkEnableOption "Fossil UI";
      package = lib.mkPackageOption pkgs "fossil" {};
      repository = lib.mkOption {
        type = lib.types.str;
        description = "The repository to host";
      };
      port = lib.mkOption {
        default = 8080;
        type = lib.types.port;
        description = "The port to use";
      };
      baseUrl = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Base URL of the server";
        example = "https://example.org/path";
      };
      useSCGI = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Whether to run fossil in SCGI mode";
      };
      localhost = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to restrict server to localhost only";
      };
      stateDir = lib.mkOption {
        default = "fossil";
        type = lib.types.str;
        description = "Name of the state directory under /var/lib";
      };
      arguments = lib.mkOption {
        default = [];
        type = lib.types.listOf lib.types.str;
        description = "List of additional arguments";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [cfg.package];
    systemd.services.fossil = {
      description = "Fossil server";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        DynamicUser = "true";
        WorkingDirectory = "/var/lib/${cfg.stateDir}";
        StateDirectory = "${cfg.stateDir}";
        Restart = "always";
        RestartSec = "3";
        ExecStart = lib.concatStringsSep " " ([
            "${cfg.package}/bin/fossil server"
            "--create"
            "--port"
            (toString cfg.port)
          ]
          ++ (lib.optionals cfg.localhost [
              "--localhost"
          ])
          ++ (lib.optionals (cfg.baseUrl != null) [
            "--baseurl"
            cfg.baseUrl
          ])
          ++ (lib.optionals cfg.useSCGI [
            "--scgi"
          ])
          ++ cfg.arguments
          ++ [
            cfg.repository
          ]);
      };
    };
  };
}
