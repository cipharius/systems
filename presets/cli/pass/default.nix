{pkgs, presets, ...}: {
  imports = [presets.cli.gnupg.default];
  environment.systemPackages = [pkgs.pass];
}
