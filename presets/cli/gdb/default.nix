{
  config,
  inputs,
  ...
}: let
  system = config.nixpkgs.hostPlatform.system;
  pkgs = inputs.self.lib.systemPkgs system inputs.nixpkgs-bleeding;
in {
  environment.systemPackages = [pkgs.gdb];
}
