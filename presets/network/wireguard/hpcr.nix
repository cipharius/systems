{inputs, ...}: {
  networking.firewall.allowedUDPPorts = [ 13231 ];
  age.secrets = {
    wireguard-hpcr-private.file = "${inputs.self}/secrets/wireguard-hpcr-private.age";
  };
  networking.wireguard.interfaces.wg0 = {
    ips = [ "192.168.1.2/24" ];
    listenPort = 13231;

    privateKeyFile = "/run/agenix/wireguard-hpcr-private";

    peers = [
      {
        publicKey = "e4fhLzPP1XB3C7kNzZr8foqAUhH79Bod4Dheks9Q6CM=";
        allowedIPs = [ "192.168.10.0/24" ];
        endpoint = "5.179.0.121:13231";
        persistentKeepalive = 25;
      }
    ];
  };
}
