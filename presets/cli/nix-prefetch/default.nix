{pkgs, ...}: {
  environment.systemPackages = [pkgs.nix-prefetch];
}
