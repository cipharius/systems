{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.fossil;
  repositoryOptions = {...}: {
    options = {
      package = lib.mkPackageOption pkgs "fossil" {};
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
      arguments = lib.mkOption {
        default = [];
        type = lib.types.listOf lib.types.str;
        description = "List of additional arguments";
      };
    };
  };
  perRepoService = repoName: let
    repoCfg = cfg.repositories."${repoName}";
  in {
    name = "fossil_${repoName}";
    value = {
      description = "Fossil server for repository ${repoName}";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        DynamicUser = "true";
        WorkingDirectory = "/var/lib/fossil_${repoName}";
        StateDirectory = "fossil_${repoName}";
        Restart = "always";
        RestartSec = "3";
        ExecStart = lib.concatStringsSep " " ([
            "${repoCfg.package}/bin/fossil server"
            "--create"
            "--port"
            (toString repoCfg.port)
          ]
          ++ (lib.optionals repoCfg.localhost [
            "--localhost"
          ])
          ++ (lib.optionals (repoCfg.baseUrl != null) [
            "--baseurl"
            repoCfg.baseUrl
          ])
          ++ (lib.optionals repoCfg.useSCGI [
            "--scgi"
          ])
          ++ repoCfg.arguments
          ++ [
            "${repoName}.fossil"
          ]);
      };
    };
  };
in {
  options = {
    services.fossil = {
      enable = lib.mkEnableOption "Fossil web UI";

      repositories = lib.mkOption {
        description = "Mapping of repository names and server configuration";
        default = {};
        type = lib.types.attrsOf (lib.types.submodule repositoryOptions);
      };
    };
  };


  config = lib.mkIf cfg.enable {
    environment.systemPackages = builtins.map (repo: repo.package) (builtins.attrValues cfg.repositories);
    systemd.services = builtins.listToAttrs (builtins.map perRepoService (builtins.attrNames cfg.repositories));
  };
}
