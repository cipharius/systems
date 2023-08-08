{pkgs, ...}: {
  environment.systemPackages = [pkgs.patchelf];
}
