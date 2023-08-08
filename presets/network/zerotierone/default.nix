{...}: {
  services.zerotierone.enable = true;
  services.zerotierone.joinNetworks = [
    "9bee8941b559dbc8"
  ];
  nixpkgs.allowUnfreeWhitelist = ["zerotierone"];
}
