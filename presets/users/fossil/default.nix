{pkgs, ...}: {
  environment.systemPackages = [pkgs.fossil];

  users.users.fossil = {
    isSystemUser = true;
    group = "fossil";
    createHome = true;
    home = "/home/fossil";
    useDefaultShell = true;
  };
  users.groups.fossil = {};
}
