{...}: {
  services.hledger-web.enable = true;
  services.hledger-web.port = 5000;
  services.hledger-web.capabilities = {
    add = true;
    manage = true;
    view = true;
  };
}
