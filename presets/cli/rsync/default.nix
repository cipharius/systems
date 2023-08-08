{pkgs, ...}: {
  environment.systemPackages = [pkgs.rsync];
}
