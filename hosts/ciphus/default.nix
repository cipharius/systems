{
  pkgs,
  presets,
  config,
  ...
}: {
  imports = with presets; [
    default
    home
    agenix

    users.root.default
    users.valts.default
    users.git.default

    server.vpsfree.default
    server.nginx.default
    server.filebrowser.default

    cli.default

    hardware.default

    network.ssh.default
    network.acme.default
  ];

  services.fail2ban.enable = true;
  services.fail2ban.jails = {
      nginx-filebrowser-login.settings = {
          filter = "nginx-filebrowser-login";
          action = ''iptables-multiport[name=HTTP, port="http,https"]'';
          logpath = "/var/log/nginx/access.log";
          backend = "auto";
      };
  };
  environment.etc = {
      "fail2ban/filter.d/nginx-filebrowser-login.conf".text = ''
      [Definition]
      failregex = ^<HOST> - .*POST /api/login HTTP/..." 403
      '';
  };

  security.acme.defaults.webroot = "/var/lib/acme/acme-challenge";
  security.acme.certs."tase.lv" = {
      group = "nginx";
      extraDomainNames = [
          "files.tase.lv"
      ];
  };

  services.nginx.virtualHosts = {
    "tase.lv" = {
      useACMEHost = "tase.lv";
      forceSSL = true;
      kTLS = true;

      locations."/" = {
        root = "/srv/web";
      };
    };

    "files.tase.lv" = {
      useACMEHost = "tase.lv";
      forceSSL = true;
      kTLS = true;

      locations."/" = {
        proxyPass = "http://localhost:${toString config.services.filebrowser.settings.port}";
      };
    };
  };

  services.nginx.clientMaxBodySize = "2g";

  services.filebrowser.openFirewall = false;
  services.filebrowser.settings.address = "127.0.0.1";
  services.filebrowser.settings.port = 5983;

  nixpkgs.hostPlatform = "x86_64-linux";

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.max-jobs = 4;
}
