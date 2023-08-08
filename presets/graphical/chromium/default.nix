{pkgs, ...}: {
  environment.systemPackages = [pkgs.chromium];
}
