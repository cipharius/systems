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
    authentication = "host personal all 192.168.8.0 255.255.255.0 password";
  };
  networking.firewall.allowedTCPPorts = [ port ];
}
