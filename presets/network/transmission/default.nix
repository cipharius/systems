{pkgs, ...}: {
  environment.systemPackages = with pkgs; [pkgs.transmission];
  boot.kernel.sysctl = {
    "net.core.rmem_max" = 4194304;
    "net.core.wmem_max" = 1048576;
  };
}
