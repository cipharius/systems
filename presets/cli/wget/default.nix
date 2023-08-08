{pkgs, ...}: {
  environment.systemPackages = [pkgs.wget];
}
