{pkgs, ...}: {
  environment.systemPackages = [pkgs.tree];
}
