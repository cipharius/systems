{pkgs, ...}: {
  networking.firewall.allowedTCPPorts = [ 51413 ];
  environment.systemPackages = with pkgs; [pkgs.transmission_4];
  boot.kernel.sysctl = {
    "net.core.rmem_max" = 4194304;
    "net.core.wmem_max" = 1048576;
  };
}
