{
  pkgs,
  presets,
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

  security.acme.defaults.webroot = "/srv/web";
  services.nginx.virtualHosts = {
    "tase.lv" = {
      addSSL = true;
      kTLS = true;
      enableACME = true;

      locations."/" = {
        root = "/srv/web";
      };
    };

    "files.tase.lv" = {
      forceSSL = true;
      kTLS = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://localhost:5983"; # Filebrowser frontend
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
