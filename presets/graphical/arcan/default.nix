{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.services.arcan;
in {
  options = {
    services.arcan = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Whether to enable arcan.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.arcan];

    systemd.services.arcan = {
      enable = true;
      description = "Arcan desktop engine";
      after = ["systemd-tmpfiles-setup.service"];
      wantedBy = ["sysinit.target"];

      script = "${pkgs.arcan}/bin/arcan ${pkgs.durden}/share/arcan/appl/durden";
      startLimitIntervalSec = 30;
      startLimitBurst = 3;

      unitConfig = {
        DefaultDependencies = false;
      };

      serviceConfig = {
        Restart = "always";
        RestartSec = "200ms";
        SyslogIdentifier = "arcan";
      };
    };
  };
}
