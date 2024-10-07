{inputs, ...}: {
  networking.firewall.allowedUDPPorts = [51820];
  networking.firewall.trustedInterfaces = ["wg2"];
  age.secrets = {
    wireguard-cronos-private.file = "${inputs.self}/secrets/wireguard-cronos-private.age";
  };
  networking.wireguard.interfaces.wg2 = {
    ips = ["192.168.99.2/24"];
    listenPort = 51820;

    privateKeyFile = "/run/agenix/wireguard-cronos-private";

    peers = [
      {
        publicKey = "WpCKSVGL0D02QBOTWg1ppJ8rH1bOwi1dhKJoS3p6bVo=";
        allowedIPs = ["192.168.99.0/24"];
        endpoint = "5.179.17.198:51820";
      }
    ];
  };
}
