{pkgs, ...}: {
  services.pulseaudio.enable = true;
  services.pulseaudio.package = pkgs.pulseaudioFull;
  services.pipewire.enable = false;
}
