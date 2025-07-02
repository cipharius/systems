{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
      virt-manager
      virtiofsd
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };

  virtualisation.spiceUSBRedirection.enable = true;
}
