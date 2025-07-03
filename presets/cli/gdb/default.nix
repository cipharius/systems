{ pkgs, ... }:
{
  environment.systemPackages = [pkgs.gdb];
}
