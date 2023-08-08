{pkgs, ...}: {
  environment.systemPackages = with pkgs; [looking-glass-client];
  systemd.tmpfiles.rules = ["f /dev/shm/looking-glass 0660 1000 libvirtd"];
}
