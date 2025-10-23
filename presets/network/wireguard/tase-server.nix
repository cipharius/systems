{inputs, ...}: {
  age.secrets = {
    wireguard-tase-server-private.file = "${inputs.self}/secrets/wireguard-tase-server-private.age";
  };
  networking.firewall.allowedUDPPorts = [13231];
  networking.firewall.trustedInterfaces = ["wg0"];
  networking.interfaces.wg0.useDHCP = false;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["192.168.8.129/24"];
      listenPort = 13231;
      privateKeyFile = "/run/agenix/wireguard-tase-server-private";
      peers = [
        {
          publicKey = "AdjaZ8z+4dnZ7tZiDCYDRuHGq4K/jmaxZCAp5xy6dEM=";
          allowedIPs = [ "192.168.8.0/25" ];
        }
        {
          publicKey = "SbAKBZ6D/L3gS5G1fYhsOwvqc9gGsagEFsA8PKQcgzQ=";
          allowedIPs = ["192.168.8.130/32"];
        }
        {
          publicKey = "N/I4r0wfMbJ8UsO963iJKd7AiScZdsdtPEAApOkbRQY=";
          allowedIPs = ["192.168.8.131/32"];
        }
        {
          publicKey = "zLFg0Zlwi4LdWmF6wS5FU01tRdfRikqkiGGlXGoRhD4=";
          allowedIPs = ["192.168.8.132/32"];
        }
        {
          publicKey = "KUXaJ8SoMZcqXtvIt7vR6C6nk/F3MNfhJvhkcAl9TxY=";
          allowedIPs = ["192.168.8.133/32"];
        }
      ];
    };
  };
}
