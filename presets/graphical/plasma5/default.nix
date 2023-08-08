{...}: {
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.driSupport32Bit = true;
}
