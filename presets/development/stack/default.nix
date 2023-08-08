{pkgs, ...}: {
  environment.systemPackages = [pkgs.stack];
}
