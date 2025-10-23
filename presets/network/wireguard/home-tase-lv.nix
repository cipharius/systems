{inputs, ...}: {
  age.secrets = {
    wireguard-home-tase-lv-private.file = "${inputs.self}/secrets/wireguard-home-tase-lv-private.age";
  };
  networking.firewall.allowedUDPPorts = [51821];
  networking.firewall.trustedInterfaces = ["wg0"];
  networking.interfaces.wg0.useDHCP = false;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["192.168.8.130/24"];
      listenPort = 51821;
      privateKeyFile = "/run/agenix/wireguard-home-tase-lv-private";
      peers = [
        {
          publicKey = "AdjaZ8z+4dnZ7tZiDCYDRuHGq4K/jmaxZCAp5xy6dEM=";
          endpoint = "[2a03:ec00:b400:9f73:50:f4ff:fe00:0]:13231";
          allowedIPs = [ "192.168.8.0/24" ];
        }
        {
            publicKey = "SbAKBZ6D/L3gS5G1fYhsOwvqc9gGsagEFsA8PKQcgzQ=";
            allowedIPs = [ "192.168.8.131/32" ];
        }
        {
          publicKey = "zLFg0Zlwi4LdWmF6wS5FU01tRdfRikqkiGGlXGoRhD4=";
          allowedIPs = ["192.168.8.132/32"];
        }
      ];
    };
  };
}
