{...}:
let
  port = 5432;
in
{
  services.postgresql = {
    enable = true;
    ensureDatabases = ["personal"];
    enableTCPIP = true;
    settings.port = port;
    authentication = ''
    host personal all 192.168.8.0 255.255.255.0 password
    host personal all 2a03:ec00:b1a0:8bb::/64 password
    '';
  };
  networking.firewall.allowedTCPPorts = [ port ];
}
