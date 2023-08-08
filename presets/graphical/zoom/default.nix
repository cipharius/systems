{pkgs, ...}: {
  nixpkgs.allowUnfreeWhitelist = [
    "zoom"
    "faac"
  ];
  environment.systemPackages = [pkgs.zoom-us];
}
