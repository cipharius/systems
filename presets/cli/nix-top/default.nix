{pkgs, ...}: {
  environment.systemPackages = [pkgs.nix-top];
}
