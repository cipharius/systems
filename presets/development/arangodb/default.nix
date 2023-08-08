{pkgs, ...}: {
  environment.systemPackages = [pkgs.arangodb];
}
