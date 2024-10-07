{pkgs, ...}: {
  hardware.sane.enable = true;
  hardware.sane.brscan4.enable = true;
  nixpkgs.allowUnfreeWhitelist = [
    "brscan4"
    "brother-udev-rule-type1"
    "brscan4-etc-files"
  ];
}
