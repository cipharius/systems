{pkgs, ...}: {
  environment.systemPackages = [pkgs.nixpkgs-fmt];
}
