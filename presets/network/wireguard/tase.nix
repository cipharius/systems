{inputs, ...}: {
  networking.firewall.allowedUDPPorts = [13232];
  networking.firewall.trustedInterfaces = ["wg1"];
  age.secrets = {
    wireguard-tase-private.file = "${inputs.self}/secrets/wireguard-tase-private.age";
  };
  networking.wireguard.interfaces.wg1 = {
    ips = ["192.168.8.130/24"];
    listenPort = 13232;

    privateKeyFile = "/run/agenix/wireguard-tase-private";

    peers = [
      {
        publicKey = "z5Pt7C1hnx5L6VJpwUIWHG6SMCcOI+TcFlV65tgyUQY=";
        allowedIPs = ["192.168.8.0/24"];
        endpoint = "37.205.10.251:13231";
      }
    ];
  };
}
