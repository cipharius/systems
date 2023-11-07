{pkgs, ...}: {
  #nixpkgs.allowUnfreeWhitelist = ["teams"];
  environment.systemPackages = [pkgs.teams-for-linux];
}
