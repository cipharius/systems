{pkgs, ...}: {
  environment.systemPackages = [pkgs.amdvlk];

  hardware.cpu.amd.updateMicrocode = true;
  boot.kernelModules = ["kvm-amd"];
}
