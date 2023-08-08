{pkgs, ...}: {
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    gutenprint
    samsung-unified-linux-driver_4_01_17
  ];
  nixpkgs.allowUnfreeWhitelist = ["samsung-UnifiedLinuxDriver"];
}
