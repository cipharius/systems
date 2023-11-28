{...}: {
  services.openssh = {
    enable = true;
    openFirewall = true;

    settings.Macs = [
      "hmac-sha2-256"
      "hmac-sha2-512"
      "hmac-sha2-256-etm@openssh.com"
      "hmac-sha2-512-etm@openssh.com"
      "umac-128-etm@openssh.com"
      "umac-128@openssh.com"
    ];
  };
}
