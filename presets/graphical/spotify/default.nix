{pkgs, ...}: {
  nixpkgs.allowUnfreeWhitelist = ["spotify" "spotify-unwrapped"];
  environment.systemPackages = [pkgs.spotify];
}
