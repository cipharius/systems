{config, ...}: {
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };

  nixpkgs.allowUnfreeWhitelist = ["nvidia" "nvidia-x11" "nvidia-settings"];
  services.xserver.videoDrivers = ["nvidia"];
}
