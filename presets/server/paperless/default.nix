{
  inputs,
  pkgs,
  ...
}:
let
  port = 2891;
in
{
  age.secrets = {
    paperless-admin.file = "${inputs.self}/secrets/paperless-admin.age";
  };

  services.paperless.enable = true;
  services.paperless.port = port;
  networking.firewall.allowedTCPPorts = [ port ];
  services.paperless.passwordFile = "/run/agenix/paperless-admin";
  services.paperless.settings = {
    PAPERLESS_AUTO_LOGIN_USERNAME = "admin";
    PAPERLESS_OCR_LANGUAGE = "lav+eng";
  };
}
