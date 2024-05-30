{
  pkgs,
  presets,
  ...
}: {
  imports = with presets; [
    default
    home
    laptop
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
    hardware.printer.default
    hardware.opengl.default
    hardware.ssd.default
    hardware.amd.default
    hardware.udisks.default
    hardware.bluetooth.default
    hardware.audio.default
    hardware.scanner.default

    graphical.default
    graphical.xserver.default
    graphical.steam.default

    development.python3.default
    development.virtualisation.default
    development.zig.default
    development.tracy.default
    development.docker.default

    network.default
    network.transmission.default
    network.wireguard.hpcr
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/2c251e55-0255-4ff4-89aa-07a5127b0748";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3927-C499";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/fc051fc4-8ca6-48cf-a425-6e913c23ed51";}
  ];

  boot.initrd.luks.devices = {
    "root".device = "/dev/disk/by-uuid/9a8fd4e3-3f40-4246-ab85-59a4e1b31b93";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.enableRedistributableFirmware = true;

  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;

  networking.nameservers = [
    "192.168.8.1"
    "fe80::2ec8:1bff:feb0:14c6"
    "91.198.156.20"
    "194.8.2.2"
    "2a02:503:8::"
    "2001:678:84::"
  ];

  time.timeZone = "Europe/Riga";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  nix.settings.max-jobs = 4;
}
