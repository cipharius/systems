{pkgs, ...}: {
  environment.systemPackages = [pkgs.dnsutils];
}
