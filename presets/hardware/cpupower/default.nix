{pkgs, ...}: {
  environment.systemPackages = [pkgs.linuxPackages.cpupower];
}
