{pkgs, ...}: {
  environment.systemPackages = [pkgs.curl];
}
