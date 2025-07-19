{...}:
let
  port = 5432;
in
{
  services.postgresql = {
    enable = true;
    ensureDatabases = ["personal"];
    settings.port = port;
  };
  networking.firewall.allowedTCPPorts = [ port ];
}
