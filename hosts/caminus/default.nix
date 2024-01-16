{
  pkgs,
  presets,
  ...
}: {
  imports = with presets; [
    default
    home
    agenix

    users.root.default
    users.valts.default

    cli.default
    cli.zk.default
    cli.croc.default
    cli.git-bug.default
    cli.imagemagick.default
    cli.openconnect.default
    cli.pandoc.default
    cli.pass.default

    hardware.default
    hardware.amd.default
    hardware.opengl.default
    hardware.nvidia.default
    hardware.ssd.default
    hardware.audio.default

    graphical.default
    graphical.xserver.default
    graphical.steam.default
    graphical.looking-glass-client.default

    development.python3.default
    development.virtualisation.default
    development.android.default

    network.ssh.default
    network.transmission.default
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/cab32824-2f7b-4b21-a6d1-8c2a1d2bb70c";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4808-6D89";
    fsType = "vfat";
  };

  swapDevices = [];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [
    # "vfio-pci.ids=1002:73ff,1002:ab28"
  ];
  boot.kernelPackages = pkgs.linuxPackages_testing;

  systemd.services.libvirtd.preStart = ''
    mkdir -p /var/lib/libvirt/hooks
    chmod 755 /var/lib/libvirt/hooks

    cat > /var/lib/libvirt/hooks/qemu <<EOF
    #!/bin/sh
    vm="\$1"
    cmd="\$2"

    if [ "\$vm" = "win10" ]; then
      if [ "\$cmd" = "started" ]; then
        # echo "0000:0c:00.0" > /sys/bus/pci/drivers/amdgpu/unbind
        # echo "0000:0c:00.0" > /sys/bus/pci/drivers/vfio-pci/bind

        systemctl set-property --runtime -- system.slice AllowedCPUs=6,7,8,9,10,11,18,19,20,21,22,23
        systemctl set-property --runtime -- user.slice AllowedCPUs=6,7,8,9,10,11,18,19,20,21,22,23
        systemctl set-property --runtime -- init.scope AllowedCPUs=6,7,8,9,10,11,18,19,20,21,22,23
      elif [ "\$cmd" = "release" ]; then
        systemctl set-property --runtime -- system.slice AllowedCPUs=0-23
        systemctl set-property --runtime -- user.slice AllowedCPUs=0-23
        systemctl set-property --runtime -- init.scope AllowedCPUs=0-23

        # echo "0000:0c:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
        # echo "0000:0c:00.0" > /sys/bus/pci/drivers/amdgpu/bind
      fi
    fi
    EOF

    chmod +x /var/lib/libvirt/hooks/qemu
  '';

  networking.networkmanager.enable = false;
  networking.useDHCP = false;
  networking.interfaces.enp6s0.wakeOnLan.enable = true;
  networking.bridges.br0.interfaces = ["enp6s0"];
  networking.interfaces.br0.ipv4.addresses = [
    {
      address = "192.168.8.8";
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = "192.168.8.1";
  networking.nameservers = ["192.168.8.1"];

  # Nescessary to prevent Xorg from freaking out about guest GPU
  # (specifically with Radeon RX 6600 XT, was fine with GTX 750Ti)
  # services.xserver.videoDrivers = [];
  # environment.systemPackages = [ pkgs.linuxPackages.nvidiaPackages.latest ];
  # services.xserver.extraConfig = ''
  # Section "Device"
  #     Identifier "Nvidia GPU"
  #     Driver "nvidia"
  #     BusID "PCI:13:00:00"
  # EndSection
  # '';

  time.timeZone = "Europe/Riga";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  nix.settings.max-jobs = 12;
}
