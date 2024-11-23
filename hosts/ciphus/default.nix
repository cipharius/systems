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
  };
  nixpkgs.hostPlatform = "x86_64-linux";

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.max-jobs = 4;
}
