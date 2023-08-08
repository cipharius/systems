{pkgs, ...}: {
  environment.systemPackages = [pkgs.haskellPackages.neuron];
}
