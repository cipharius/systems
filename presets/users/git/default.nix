{pkgs, ...}: {
  environment.systemPackages = [pkgs.git];

  users.users.git = {
    isSystemUser = true;
    group = "git";
    createHome = true;
    home = "/home/git";
    useDefaultShell = true;
  };
  users.groups.git = {};
}
