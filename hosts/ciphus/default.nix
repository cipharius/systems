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
    server.fossil.default

    cli.default

    hardware.default

    network.ssh.default
    network.acme.default
  ];

  services.fail2ban.enable = true;
  services.fail2ban.jails = {
    nginx-fossil-login.settings = {
      filter = "nginx-fossil-login";
      action = ''iptables-multiport[name=HTTP, port="http,https"]'';
      logpath = "/var/log/nginx/access.log";
      backend = "auto";
    };
    nginx-filebrowser-login.settings = {
      filter = "nginx-filebrowser-login";
      action = ''iptables-multiport[name=HTTP, port="http,https"]'';
      logpath = "/var/log/nginx/access.log";
      backend = "auto";
    };
  };
  environment.etc = {
    "fail2ban/filter.d/nginx-fossil-login.conf".text = ''
      [Definition]
      failregex = ^<HOST> - .*POST .*/login HTTP/..." 401
    '';
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
      "smash.tase.lv"
      "arcan.tase.lv"
    ];
  };

  services.nginx.virtualHosts = let
    nginxPackage = config.services.nginx.package;
  in {
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

    "smash.tase.lv" = {
      useACMEHost = "tase.lv";
      forceSSL = true;
      kTLS = true;

      locations."/" = {
        # scgi_pass localhost:${toString config.services.fossil.repositories.smash.port};
        extraConfig = ''
          include ${nginxPackage}/conf/scgi_params;
          scgi_pass localhost:9000;
          scgi_param SCRIPT_NAME "";
        '';
      };
    };

    "arcan.tase.lv" = {
      useACMEHost = "tase.lv";
      forceSSL = true;
      kTLS = true;

      locations."/" = {
        # scgi_pass localhost:${toString config.services.fossil.repositories.arcan.port};
        extraConfig = ''
          include ${nginxPackage}/conf/scgi_params;
          scgi_pass localhost:9001;
          scgi_param SCRIPT_NAME "";
        '';
      };
    };
  };

  services.fossil.repositories = {
    smash = {
      useSCGI = true;
      localhost = true;
      baseUrl = "https://smash.tase.lv/";
      port = 9000;
    };
    arcan = {
      useSCGI = true;
      localhost = true;
      baseUrl = "https://arcan.tase.lv/";
      port = 9001;
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
