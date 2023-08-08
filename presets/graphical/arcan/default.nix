{pkgs, ...}: {
  environment.systemPackages = [pkgs.arcanPackages.arcan];
}
