{
  self,
  pkgs,
  ...
}: {
  age.secrets = {
    paperless-admin.file = "${self}/secrets/paperless-admin.age";
  };

  services.paperless-ng.enable = true;
  services.paperless-ng.port = 28981;
  services.paperless-ng.passwordFile = "/run/agenix/paperless-admin";
  services.paperless-ng.extraConfig = {
    PAPERLESS_AUTO_LOGIN_USERNAME = "admin";
    PAPERLESS_OCR_LANGUAGE = "lav+eng";
  };
}
